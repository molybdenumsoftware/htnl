let
  workflows = {
    check = {
      on = {
        push = { };
        workflow_call = { };
      };
      jobs.check = {
        runs-on = "ubuntu-latest";
        steps = [
          { uses = "actions/checkout@v5"; }
          { uses = "DeterminateSystems/nix-installer-action@main"; }
          { uses = "DeterminateSystems/magic-nix-cache-action@main"; }
          { run = "nix flake -vv --print-build-logs --accept-flake-config check"; }
        ];
      };
    };
    publish-website = {
      on = {
        pull_request = { };
        # TODO uncomment?
        #push.branches = [ "master" ];
        push = { };
      };

      permissions = {
        contents = "read";
        pages = "write";
        id-token = "write";
      };

      concurrency = {
        group = "\${{ github.workflow }}-\${{ github.ref_name }}";
        cancel-in-progress = true;
      };

      jobs.docs = {
        runs-on = "ubuntu-latest";
        steps = [
          { uses = "actions/checkout@v4"; }
          { uses = "DeterminateSystems/nix-installer-action@main"; }
          { uses = "DeterminateSystems/magic-nix-cache-action@main"; }
          { run = "nix build .#website"; }
          {
            uses = "actions/upload-pages-artifact@v4";
            "with".path = "result";
          }
          {
            "if" = "github.ref == 'refs/heads/\${{ github.event.repository.default_branch }}'";
            uses = "actions/deploy-pages@v4";
          }
        ];
      };
    };
  };
in
{
  perSystem =
    { lib, pkgs, ... }:
    workflows
    |> lib.attrsToList
    |> map (
      { name, value }:
      let
        path_ = ".github/workflows/${name}.yaml";
      in
      {
        files.files = [
          {
            inherit path_;
            drv = pkgs.writers.writeJSON "gh-actions-workflow-${name}.yaml" value;
          }
        ];
        treefmt.settings.global.excludes = [ path_ ];
      }
    )
    |> lib.mkMerge;
}
