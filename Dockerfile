
# Extend from the official Elixir image.
FROM elixir:latest

# Create app directory and copy the Elixir projects into it.
RUN mkdir /app
COPY . /app

WORKDIR /app

# Install Hex package manager.
# By using `--force`, we don’t need to type “Y” to confirm the installation.
RUN mix local.hex --force
RUN mix local.rebar --force

RUN mix deps.get
RUN mix phx.digest

# Compile the project.
RUN MIX_ENV=prod mix compile

ENV MIX_ENV=prod
CMD [ "bash", "./run-server.sh" ]
