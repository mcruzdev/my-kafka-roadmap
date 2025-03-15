package dev.matheuscruz;

import java.time.Duration;
import java.util.Map;
import java.util.UUID;

import org.eclipse.microprofile.reactive.messaging.Outgoing;

import io.smallrye.common.annotation.NonBlocking;
import io.smallrye.mutiny.Multi;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;

@Path("/hello")
public class GreetingResource {

    @GET
    @Produces(MediaType.TEXT_PLAIN)
    public String hello() {
        return "Hello from Quarkus REST";
    }

    @Outgoing("orders-confirmed")
    @NonBlocking
    public Multi<Map<String, String>> generate() {
        return Multi.createFrom().ticks().every(Duration.ofSeconds(2)).map(x -> {
            return Map.of("orderId", UUID.randomUUID().toString());
        });
    }

}
