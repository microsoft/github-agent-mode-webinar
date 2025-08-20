package com.github.av2.api.model;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Schema(description = "Delivery information")
public class Delivery {
    @Schema(description = "The unique identifier for the delivery", required = true)
    private Integer deliveryId;
    
    @Schema(description = "The ID of the supplier providing this delivery", required = true)
    private Integer supplierId;
    
    @Schema(description = "Delivery date and time")
    private String deliveryDate;
    
    @Schema(description = "The name of the delivery", required = true)
    private String name;
    
    @Schema(description = "Description of the delivery")
    private String description;
    
    @Schema(description = "The status of the delivery", required = true)
    private String status;
}