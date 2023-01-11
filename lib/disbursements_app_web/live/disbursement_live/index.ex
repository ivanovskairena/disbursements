defmodule DisbursementsAppWeb.DisbursementLive.Index do
  use DisbursementsAppWeb, :live_view

  alias DisbursementsApp.Disb
  alias DisbursementsApp.Disb.Disbursement
  require Logger

  @impl true
  def mount(_params, _session, socket) do

    params =
      %{"merchant_id" => "", "week" => ""}

    disbursement =
      %Disbursement{}

    changeset =
      Disb.change_disbursement(disbursement)

    assigns = [
      disbursements: Disb.list(params),
      merchants: list_merchants() |> Enum.map(&{&1.name, &1.id}),
      weeks: 1..52,
      disbursement: disbursement,
      changeset: changeset
    ]

    {:ok, assign(socket, assigns)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end


  def handle_event("filter", %{"disbursement" => params}, socket) do

    changeset =
      %Disbursement{}
      |> Disb.change_disbursement(params)
      |> Map.put(:action, :validate)

    disbursements =
      Disb.list(params)

    assigns = [
      disbursements: disbursements,
      changeset: changeset
    ]

    {:noreply, assign(socket, assigns)}
  end


  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Disbursement")
    |> assign(:disbursement, Disb.get_disbursement!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Disbursement")
    |> assign(:disbursement, %Disbursement{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Disbursements")
    |> assign(:disbursement, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    disbursement = Disb.get_disbursement!(id)
    {:ok, _} = Disb.delete_disbursement(disbursement)

    {:noreply, assign(socket, :disbursements, list_disbursements())}
  end

  defp list_disbursements do
    Disb.list_disbursements() |> DisbursementsApp.Repo.preload(:merchant)
  end

  defp list_merchants do
    Disb.list_merchants()
  end



end
