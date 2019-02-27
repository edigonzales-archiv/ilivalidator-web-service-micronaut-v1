./gradlew assemble
java -cp build/libs/ilivalidator-web-service-micronaut-*.jar io.micronaut.graal.reflect.GraalClassLoadingAnalyzer
$GRAALVM_HOME/bin/native-image --no-server \
             --class-path build/libs/ilivalidator-web-service-micronaut-*.jar \
             -H:ReflectionConfigurationFiles=build/reflect.json \
             -H:ReflectionConfigurationFiles=ilivalidator.json \
             -H:EnableURLProtocols=http \
             -H:IncludeResources="logback.xml|application.yml" \
             -H:IncludeResourceBundles=org.interlis2.validator.Version \
             -H:IncludeResourceBundles=ch.interlis.ili2c.Version \
             -H:IncludeResourceBundles=ch/interlis/iox_j/Version \
             -H:IncludeResourceBundles=ch.interlis.ili2c.metamodel.ErrorMessages \
             -H:Log=registerResource \
             -H:Name=ilivalidator-web-service-micronaut \
             -H:Class=ilivalidator.web.service.micronaut.Application \
             -H:+ReportUnsupportedElementsAtRuntime \
             -H:+AllowVMInspection \
             --allow-incomplete-classpath \
             --rerun-class-initialization-at-runtime='sun.security.jca.JCAUtil$CachedSecureRandomHolder,javax.net.ssl.SSLContext' \
             --delay-class-initialization-to-runtime=io.netty.handler.codec.http.HttpObjectEncoder,io.netty.handler.codec.http.websocketx.WebSocket00FrameEncoder,io.netty.handler.ssl.util.ThreadLocalInsecureRandom,com.sun.jndi.dns.DnsClient
