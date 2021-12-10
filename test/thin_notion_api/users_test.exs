defmodule ThinNotionApi.UsersTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

	alias ThinNotionApi.Users

  setup_all do
    HTTPoison.start
  end

  test "GET retrieve_user" do
    use_cassette "get_retieve_user" do
      {:ok, response} = Users.retrieve_user("887fba53-b2e3-4692-8bb1-1aa3cf0667e6")

      assert get_in(response, ["name"]) == "Erik Guzman"
    end
  end

  test "GET list_all_users" do
    use_cassette "get_list_all_users" do
      {:ok, response} = Users.list_all_users()

      assert get_in(response, ["results"]) |> List.first |> get_in(["name"]) == "Erik Guzman"
    end
  end
end
