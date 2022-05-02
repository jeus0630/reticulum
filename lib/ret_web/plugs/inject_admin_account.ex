defmodule RetWeb.Plugs.InjectAdminAccount do
    import Plug.Conn
    import Ecto.Query

    alias Ret.{Account, Repo}

    def init(default), do: default

    def call(conn, _default) do
        account = (from a in Account, where: a.is_admin == true) |> Repo.one()
        credentials = account |> Account.credentials_for_account()
        
        conn
            |> merge_private(guardian_default_claims: Ret.SessionToken.decode_and_verify(credentials))
            |> merge_private(guardian_default_resource: account)
            |> put_req_header("authorization", "bearer "<>credentials)

    end
end
