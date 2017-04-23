defmodule DocSpec do
  @moduledoc """
  Documentation for DocSpec.
  """
  defmacro __using__(args) do
    IO.inspect "using"
    IO.inspect args
    quote do
      @on_definition {unquote(__MODULE__), :on_def}
      @before_compile unquote(__MODULE__)
      @after_compile unquote(__MODULE__)
      import DocSpec, only: [on_def: 6]
      Module.register_attribute(__MODULE__,
      :docspec, 
      accumulate: true)
    end
  end

  defmacro __before_compile__(env) do
    IO.inspect "before compile"
    current_module = env.module
  end

  defmacro __after_compile__(env, _bytes) do
    IO.inspect "after_compile"
    current_module = env.module
    Module.get_attribute(current_module, :docspec)
    |> Enum.each(&(run_docspec(&1, current_module)))
    quote do end
  end

  defp run_docspec(string, module) do
    IO.inspect(string |> String.split("\n"))
    File.write("test/test_attributes_test.exs", test())
  end

  defp test do
    """
    defmodule TestAttributesTest do
      use ExUnit.Case

      test "should test the truth" do
        assert 3 == 2
      end
    end
    """
  end

  def on_def(env, kind, name, args, guards, body) do
    IO.inspect "on def"
    current_module = env.module
    
    quote do
    end

  end
end
