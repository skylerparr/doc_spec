defmodule DocSpec do
  
  defmacro __using__(args) do
    IO.inspect "using"
    IO.inspect args
    quote do
      @after_compile unquote(__MODULE__)
      import DocSpec, only: [on_def: 6]
      Module.register_attribute(__MODULE__,
      :docspec, 
      accumulate: true)
    end
  end

  defmacro __after_compile__(env, _bytes) do
    IO.inspect "after_compile"
    current_module = env.module
    Module.get_attribute(current_module, :docspec)
    |> Enum.each(&(run_docspec(&1, current_module)))
    quote do end
  end

  defp run_docspec(string, module) do
    docs = DocParser.parse(string)
    IO.inspect docs
    options = string 
      |> String.split("\n")
      |> Enum.filter(&(&1 != ""))
      |> extract_cases
    #|> map_cases
    #create_test_file(module)
  end

  defp extract_cases(items) do
    items
    #|> Enum.scan({nil, %{}}, &reduce_items/2)
    #|> List.last
    #|> IO.inspect
  end

  defp get_state(item) do
    case item do
      "Case:" -> :cases
      "Given:" -> :given
      "Example:" -> :examples
      _ -> nil
    end
  end

  defp create_test_file(content, module) do
    full_file_name = "test/#{module |> Macro.underscore}_test.exs"
    file_name = full_file_name |> Path.basename
    path = full_file_name |> Path.dirname

    File.mkdir_p(path)
    File.write("#{path}/#{file_name}", content)
  end

  def on_def(env, kind, name, args, guards, body) do
    IO.inspect "on def"
    current_module = env.module
    
    quote do
    end

  end
end
