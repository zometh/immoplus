package com.immoplus.app.immoplus.entities;

import jakarta.persistence.Entity;
import lombok.*;

import java.util.List;


@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class ImmeubleDashboardEntity {
    int nbContrats;
    int nbUnites;
    int nbUnitesDisponibles;
    List<Immeuble> immeubles;
    double totalLocation;
}
