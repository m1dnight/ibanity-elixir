defmodule Ibanity.FinancialInstitution do
  @moduledoc """
  Financial institutions API wrapper
  """

  use Ibanity.Resource

  defstruct [
    id: nil,
    sandbox: true,
    name: nil,
    self_link: nil
  ]

  @resource_id_name :financialInstitutionId
  @resource_type "financialInstitution"

  @sandbox_api_schema_path ["sandbox", "financialInstitutions"]
  @find_api_schema_path    ["financialInstitutions"]

  def list, do: list(%Request{})
  def list(%Request{customer_access_token: nil} = request) do
    request
    |> Request.id(:financialInstitutionId, "")
    |> HttpRequest.build(:get, ["financialInstitutions"])
    |> Client.execute(__MODULE__)
  end
  def list(%Request{} = request) do
    request
    |> HttpRequest.build(:get, ["customer", "financialInstitutions"])
    |> Client.execute(__MODULE__)
  end

  def find(id) when is_binary(id), do: find(%Request{resource_ids: [{@resource_id_name, id}]})
  def find(%Request{} = request) do
    request
    |> HttpRequest.build(:get, @find_api_schema_path)
    |> Client.execute(__MODULE__)
  end

  def create(%Request{} = request) do
    request
    |> Request.id(:financialInstitutionId, "")
    |> HttpRequest.build(:post, @sandbox_api_schema_path, @resource_type)
    |> Client.execute(__MODULE__)
  end

  def update(%Request{} = request) do
    request
    |> HttpRequest.build(:patch, @sandbox_api_schema_path, @resource_type)
    |> Client.execute(__MODULE__)
  end

  def delete(id) when is_binary(id), do: delete(%Request{resource_ids: [{@resource_id_name, id}]})
  def delete(%Request{} = request) do
    request
    |> HttpRequest.build(:delete, @sandbox_api_schema_path)
    |> Client.execute(__MODULE__)
  end

  def key_mapping do
    [
      id: ~w(id),
      sandbox: ~w(attributes sandbox),
      name: ~w(attributes name),
      self_link: ~w(links self)
    ]
  end
end
