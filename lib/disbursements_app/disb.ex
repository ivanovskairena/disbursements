defmodule DisbursementsApp.Disb do
  @moduledoc """
  The Disb context.
  """
  import Ecto.Query, warn: false
  alias DisbursementsApp.Repo
  use Timex
  import Logger
  alias DisbursementsApp.Disb.Merchant

  @doc """
  Returns the list of merchants.

  ## Examples

      iex> list_merchants()
      [%Merchant{}, ...]

  """
  def list_merchants do
    Repo.all(Merchant)
  end

  @doc """
  Gets a single merchant.

  Raises `Ecto.NoResultsError` if the Merchant does not exist.

  ## Examples

      iex> get_merchant!(123)
      %Merchant{}

      iex> get_merchant!(456)
      ** (Ecto.NoResultsError)

  """
  def get_merchant!(id), do: Repo.get!(Merchant, id)

  @doc """
  Creates a merchant.

  ## Examples

      iex> create_merchant(%{field: value})
      {:ok, %Merchant{}}

      iex> create_merchant(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_merchant(attrs \\ %{}) do
    %Merchant{}
    |> Merchant.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a merchant.

  ## Examples

      iex> update_merchant(merchant, %{field: new_value})
      {:ok, %Merchant{}}

      iex> update_merchant(merchant, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_merchant(%Merchant{} = merchant, attrs) do
    merchant
    |> Merchant.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a merchant.

  ## Examples

      iex> delete_merchant(merchant)
      {:ok, %Merchant{}}

      iex> delete_merchant(merchant)
      {:error, %Ecto.Changeset{}}

  """
  def delete_merchant(%Merchant{} = merchant) do
    Repo.delete(merchant)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking merchant changes.

  ## Examples

      iex> change_merchant(merchant)
      %Ecto.Changeset{data: %Merchant{}}

  """
  def change_merchant(%Merchant{} = merchant, attrs \\ %{}) do
    Merchant.changeset(merchant, attrs)
  end

  alias DisbursementsApp.Disb.Shopper

  @doc """
  Returns the list of shoppers.

  ## Examples

      iex> list_shoppers()
      [%Shopper{}, ...]

  """
  def list_shoppers do
    Repo.all(Shopper)
  end

  @doc """
  Gets a single shopper.

  Raises `Ecto.NoResultsError` if the Shopper does not exist.

  ## Examples

      iex> get_shopper!(123)
      %Shopper{}

      iex> get_shopper!(456)
      ** (Ecto.NoResultsError)

  """
  def get_shopper!(id), do: Repo.get!(Shopper, id)

  @doc """
  Creates a shopper.

  ## Examples

      iex> create_shopper(%{field: value})
      {:ok, %Shopper{}}

      iex> create_shopper(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_shopper(attrs \\ %{}) do
    %Shopper{}
    |> Shopper.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a shopper.

  ## Examples

      iex> update_shopper(shopper, %{field: new_value})
      {:ok, %Shopper{}}

      iex> update_shopper(shopper, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_shopper(%Shopper{} = shopper, attrs) do
    shopper
    |> Shopper.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a shopper.

  ## Examples

      iex> delete_shopper(shopper)
      {:ok, %Shopper{}}

      iex> delete_shopper(shopper)
      {:error, %Ecto.Changeset{}}

  """
  def delete_shopper(%Shopper{} = shopper) do
    Repo.delete(shopper)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking shopper changes.

  ## Examples

      iex> change_shopper(shopper)
      %Ecto.Changeset{data: %Shopper{}}

  """
  def change_shopper(%Shopper{} = shopper, attrs \\ %{}) do
    Shopper.changeset(shopper, attrs)
  end

  alias DisbursementsApp.Disb.Order

  def list_orders do
    Repo.all(Order)
    |> Repo.preload(:merchant)
    |> Repo.preload(:shopper)
    |> Repo.preload(:disbursement)
  end



  @doc """
  Gets a single order.

  Raises `Ecto.NoResultsError` if the Order does not exist.

  ## Examples

      iex> get_order!(123)
      %Order{}

      iex> get_order!(456)
      ** (Ecto.NoResultsError)

  """

  def get_order!(id), do: Repo.get!(Order, id)

  @doc """
  Creates a order.

  ## Examples

      iex> create_order(%{field: value})
      {:ok, %Order{}}

      iex> create_order(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_order(attrs \\ %{}) do
    %Order{}
    |> Order.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a order.

  ## Examples

      iex> update_order(order, %{field: new_value})
      {:ok, %Order{}}

      iex> update_order(order, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_order(%Order{} = order, attrs) do
    order
    |> Order.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a order.

  ## Examples

      iex> delete_order(order)
      {:ok, %Order{}}

      iex> delete_order(order)
      {:error, %Ecto.Changeset{}}

  """
  def delete_order(%Order{} = order) do
    Repo.delete(order)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking order changes.

  ## Examples

      iex> change_order(order)
      %Ecto.Changeset{data: %Order{}}

  """
  def change_order(%Order{} = order, attrs \\ %{}) do
    Order.changeset(order, attrs)
  end

  alias DisbursementsApp.Disb.Disbursement

  @doc """
  Returns the list of disbursements.

  ## Examples

      iex> list_disbursements()
      [%Disbursement{}, ...]

  """
  def list_disbursements do
    Repo.all(Disbursement)
  end

  def list(params) do
    Disbursement
    |> filter_merchant(params["merchant_id"])
    |> filter_week(params["week"])
    |> Repo.all()
    |> DisbursementsApp.Repo.preload(:merchant)
  end


  def list_by_merchant_week(params) do
    Disbursement
    |> join(:left, [d], m in assoc(d, :merchant))
    |> filter_merchant(params["merchant_id"])
    |> filter_week(params["week"])
    |> group_by([d, m], [d.id, m.id])
    |> Repo.all()
    |> DisbursementsApp.Repo.preload(:merchant)

  end


  defp filter_merchant(query, merchant) when merchant in ["", nil], do: query
  defp filter_merchant(query, merchant) do
    merchant = String.to_integer(merchant)

    query |> where([d], d.merchant_id == ^merchant)
  end

  defp filter_week(query, week) when week in ["", nil], do: query
  defp filter_week(query, week) do
    week = String.to_integer(week)

    query |> where([d], d.week == ^week)
  end


  @doc """
  Gets a single disbursement.

  Raises `Ecto.NoResultsError` if the Disbursement does not exist.

  ## Examples

      iex> get_disbursement!(123)
      %Disbursement{}

      iex> get_disbursement!(456)
      ** (Ecto.NoResultsError)

  """
  def get_disbursement!(id), do: Repo.get!(Disbursement, id)


  @doc """
  Creates a disbursement.

  ## Examples

      iex> create_disbursement(%{field: value})
      {:ok, %Disbursement{}}

      iex> create_disbursement(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_disbursement(attrs \\ %{}) do
    %Disbursement{}
    |> Disbursement.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a disbursement.

  ## Examples

      iex> update_disbursement(disbursement, %{field: new_value})
      {:ok, %Disbursement{}}

      iex> update_disbursement(disbursement, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_disbursement(%Disbursement{} = disbursement, attrs) do
    disbursement
    |> Disbursement.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a disbursement.

  ## Examples

      iex> delete_disbursement(disbursement)
      {:ok, %Disbursement{}}

      iex> delete_disbursement(disbursement)
      {:error, %Ecto.Changeset{}}

  """
  def delete_disbursement(%Disbursement{} = disbursement) do
    Repo.delete(disbursement)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking disbursement changes.

  ## Examples

      iex> change_disbursement(disbursement)
      %Ecto.Changeset{data: %Disbursement{}}

  """
  def change_disbursement(%Disbursement{} = disbursement, attrs \\ %{}) do
    Disbursement.changeset(disbursement, attrs)
  end
end
