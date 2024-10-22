{ pkgs, ... }: {
    services.postgresql = {
      enable = true;
      package = pkgs.postgresql_16;
      authentication = pkgs.lib.mkOverride 10 ''
        #type database  DBuser  auth-method
        local all       all     trust
      '';
    };
}
