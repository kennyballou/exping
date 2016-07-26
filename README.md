# ExPing #

Test service availablility through a series of requests.

## Installation ##

The package can be installed as:

1.  Add `exping` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:exping, "~> 0.1.0"}]
end
```

2.  Ensure `exping` is started before your application:

```elixir
def application do
  [applications: [:exping]]
end
```

## License ##

This code is provided AS-IS, WITHOUT any warranty, expressed or implied, under
the terms and conditions of the Apache, version 2.0, license. For more
information, see the provided LICENSE file. If your distribution did not come
with a LICENSE file, you may read about the terms [online][1].

[1]: http://www.apache.org/licenses/LICENSE-2.0
