
# Extend from the official Elixir image.
FROM elixir:1.13

# Create app directory and copy the Elixir projects into it.
RUN mkdir /app
COPY . /app

WORKDIR /app

ARG MIX_ENV=prod
ARG ROOT_PATH=/
# Install Hex package manager.
# By using `--force`, we don’t need to type “Y” to confirm the installation.
RUN mix local.hex --force
RUN mix local.rebar --force

RUN mix deps.get
RUN mix phx.digest
RUN mix assets.deploy

# Compile the project.
RUN mix compile

ENV MIX_ENV=prod
ENV ROOT_PATH=$ROOT_PATH
EXPOSE 4000
CMD [ "bash", "./run-server.sh" ]
