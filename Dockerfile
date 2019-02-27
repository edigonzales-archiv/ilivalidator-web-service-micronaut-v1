FROM oracle/graalvm-ce:1.0.0-rc11 as graalvm
COPY . /home/app/ilivalidator-web-service-micronaut
WORKDIR /home/app/ilivalidator-web-service-micronaut
RUN ./build-native-image.sh

FROM frolvlad/alpine-glibc
EXPOSE 8080
COPY --from=graalvm /home/app/ilivalidator-web-service-micronaut .
ENTRYPOINT ["./ilivalidator-web-service-micronaut"]
