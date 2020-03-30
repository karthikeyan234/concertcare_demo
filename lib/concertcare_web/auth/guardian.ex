defmodule ConcertcareWeb.Auth.Guardian do
  use Guardian, otp_app: :concertcare

  alias Concertcare.Accounts

  def subject_for_token(resource, _claims) do

    sub = to_string(resource.id)
    {:ok, sub}
  end
  def subject_for_token(_, _) do
    {:error, :reason_for_error}
  end

  def resource_from_claims(claims) do

    id = claims["sub"]
    resource = Accounts.get_user!(id)
    {:ok,  resource}
  end
  def resource_from_claims(_claims) do
    {:error, :reason_for_error}
  end

  def authenticate(email, password) do
    with {:ok, user} <- Accounts.get_user_by_email!(email) do

      case validate_password(password, user.password_hash) do
        true ->
          create_token(user)
        false ->
          {:error, :unauthorized}
      end
    end
  end

  defp validate_password(password, password_hash) do

    Pbkdf2.verify_pass(password, password_hash)
  end

  defp create_token(user) do
    {:ok, token, _claims} = encode_and_sign(user)
    {:ok, user, token}
  end
end