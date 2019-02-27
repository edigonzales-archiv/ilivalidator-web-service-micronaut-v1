# ilivalidator-web-service-micronaut
ilivalidator web service with micronaut and graalvm

## GraalVM / native image
```
mn create-app --features file-watch --features graal-native-image ilivalidator-web-service-micronaut
cd ilivalidator-web-service-micronaut
mn create-controller Main
./gradlew eclipse
```

```
./gradlew run --continuous
```

```
./build-native-image.sh
```
(`native-image` muss im PATH sein, sonst Befehl entsprechend anpassen.)

### Probleme
- `micronaut.server.multiplart.maxFileSize` setzen in `application.yml` führt zu Startup-Fehlern.


## Application
```
curl -v -XPOST -F file=@ch_254900.itf "http://localhost:8080/ilivalidator"
```
