defmodule DisbursementsAppWeb.DisbursementLive.FormComponent do
  use DisbursementsAppWeb, :live_component

  alias DisbursementsApp.Disb

  @impl true
  def update(%{disbursement: disbursement} = assigns, socket) do
    changeset = Disb.change_disbursement(disbursement)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"disbursement" => disbursement_params}, socket) do
    changeset =
      socket.assigns.disbursement
      |> Disb.change_disbursement(disbursement_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"disbursement" => disbursement_params}, socket) do
    save_disbursement(socket, socket.assigns.action, disbursement_params)
  end

  defp save_disbursement(socket, :edit, disbursement_params) do
    case Disb.update_disbursement(socket.assigns.disbursement, disbursement_params) do
      {:ok, _disbursement} ->
        {:noreply,
         socket
         |> put_flash(:info, "Disbursement updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_disbursement(socket, :new, disbursement_params) do
    case Disb.create_disbursement(disbursement_params) do
      {:ok, _disbursement} ->
        {:noreply,
         socket
         |> put_flash(:info, "Disbursement created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
