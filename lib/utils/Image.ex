defmodule Challenge.Utils.File do
  def move(image, directory_destination) do
    extension = Path.extname(image.filename)
    {:ok, cwd} = File.cwd()
    file_name = "#{UUID.uuid1()}#{extension}"

    target_path = "#{cwd}#{directory_destination}/#{file_name}"

    case File.cp(image.path, target_path) do
      :ok -> {:ok, file_name, target_path}
      {:error, reason} -> {:error, reason}
    end
  end
end
