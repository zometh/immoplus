package com.immoplus.app.immoplus.entities;

import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class AdminDashboardEntity {

    private int totalImmeubles;
    private int totalProprietaires;
    private int totalDemandes;
    private int totalLocataires;
    private int totalContrats;
    private int totalUnites;

}
