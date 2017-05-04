defmodule DocParser do
  def parse(string) do 
    string 
    |> String.split("\n")
    |> Enum.filter(&(&1 != ""))
    |> extract_topics
    |> Enum.reduce(Keyword.new, &to_map/2)
  end

  defp to_map({k,v}, []) do
    [{k, [v]}]
  end
  defp to_map({k,v}, acc) do
    last_key = acc |> List.last |> elem(0)
    if(last_key == k) do
      Keyword.put(acc, k, (Keyword.get(acc |> Enum.reverse, k) || []) ++ [v])
      |> Enum.reverse
    else 
      acc ++ [{k, [v]}]
    end
  end

  defp extract_topics(frags) do
    do_extract(frags, [], nil)
  end

  defp do_extract([], acc, _), do: acc
  defp do_extract([head|tail], acc, nil) do
    t = get_topic(head)
    if(is_topic?(t)) do 
      do_extract(tail, acc, t |> sanitize_topic)
    else
      do_extract(tail, acc, nil)
    end
  end
  defp do_extract([head|tail], acc, topic) do
    t = get_topic(head)
    if(is_topic?(t)) do 
      do_extract(tail, acc, t |> sanitize_topic)
    else
      acc = acc ++ [{topic, head}]
      do_extract(tail, acc, topic)
    end
  end

  defp sanitize_topic(topic) do
    topic
    |> strip_colon
    |> Macro.underscore
    |> String.to_atom
  end

  defp strip_colon(string) do
    string
    |> String.split(":")
    |> hd
  end

  defp get_topic(string) do
    string
    |> String.trim
    |> String.split(" ")
    |> hd
  end

  defp is_topic?(string) do 
    string
    |> String.ends_with?(":")
  end

  defp group_term do 
    Application.get_env(:doc_spec, :group_term)
  end
end
