FROM heroiclabs/nakama-pluginbuilder:3.24.2 AS builder

ENV GO111MODULE on
ENV CGO_ENABLED 1

WORKDIR /backend
COPY . .

RUN go build --trimpath --buildmode=plugin -o ./backend.so

FROM heroiclabs/nakama:3.24.2

COPY --from=builder /backend/backend.so /nakama/data/modules
COPY --from=builder /backend/local.yml /nakama/data/
COPY --from=builder /backend/*.json /nakama/data/modules