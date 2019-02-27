package ilivalidator.web.service.micronaut;

import io.micronaut.http.annotation.Controller;
import io.micronaut.http.annotation.Get;
import io.micronaut.http.annotation.Post;
import io.micronaut.http.multipart.CompletedFileUpload;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import io.micronaut.http.HttpResponse;
import io.micronaut.http.HttpStatus;
import io.micronaut.http.MediaType;

@Controller("/ilivalidator")
public class MainController {
    private static final Logger log = LoggerFactory.getLogger(MainController.class);

    @Inject
    ValidationService validationService;

    @Get("/")
    public HttpStatus index() {
        return HttpStatus.OK;
    }
    
    @Post(value = "/", consumes = MediaType.MULTIPART_FORM_DATA, produces = MediaType.TEXT_PLAIN) 
    public HttpResponse<String> uploadCompleted(CompletedFileUpload file) { 
        try {
            File inputFile = File.createTempFile(file.getFilename(), "temp"); 
            log.debug(inputFile.getAbsolutePath());
            Path path = Paths.get(inputFile.getAbsolutePath());
            Files.write(path, file.getBytes()); 
            
            File logFile = File.createTempFile(file.getFilename(), "temp.log");
            log.debug(logFile.getAbsolutePath());
            
            boolean valid = validationService.validate(inputFile.getAbsolutePath(), logFile.getAbsolutePath());
            Path logFilePath = Paths.get(logFile.getAbsolutePath());
            String logFileContent = new String(Files.readAllBytes(logFilePath));
            
            return HttpResponse.ok(logFileContent).header("Content-Type", "text/plain; charset=utf-8")
                    .contentLength(logFile.length());      
        } catch (IOException e) {
            e.printStackTrace();
            log.error(e.getMessage());
            return HttpResponse.badRequest("Something went wrong.");
        }
    }
}