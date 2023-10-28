## Build
FROM golang:latest AS build

WORKDIR /app

# Install dependencies
COPY go.mod ./
COPY go.sum ./
RUN go mod download

# Copy source code
COPY ./cmd/api ./

# Build the binary
RUN go build -o /api

## Deploy
FROM scratch

COPY --from=build /api /api

EXPOSE 9091

# Run the binary
ENTRYPOINT ["/api"]
