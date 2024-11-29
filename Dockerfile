FROM openjdk:17-alpine AS build

WORKDIR /build

COPY . .

RUN chmod 755 ./mvnw && ./mvnw clean package

# Use separate stage for deployable java archive
FROM openjdk:17-alpine

# Create a non-privileged user that the app will run under
ARG UID=10001
RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "/nonexistent" \
    --shell "/sbin/nologin" \
    --no-create-home \
    --uid "${UID}" \
    appuser
USER appuser

WORKDIR /backend

COPY --from=build /build/target/* ./

RUN mv demo-*.jar demo.jar

CMD [ "java", "-jar", "demo.jar", "--server.port=9000" ]

EXPOSE 9000
