package com.immoplus.app.immoplus.entities;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.proxy.HibernateProxy;

import java.time.LocalDate;
import java.util.List;
import java.util.Objects;
import java.util.UUID;

@Entity
@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class ContratLocation {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private LocalDate dateDebut = LocalDate.now();
    private LocalDate dateFin;
    private LocalDate dateProchainPaiement = dateDebut.plusMonths(1);
    @Enumerated(EnumType.STRING)
    private LocationStatut statut;
    private String reference = "CONTRAT-" + UUID.randomUUID().toString();
    @ManyToOne
    @JoinColumn(name = "unite_id")
    private UniteLocation unite;

    @ManyToOne
    @JoinColumn(name = "locataire_id")
    private Utilisateur locataire;

    @OneToMany(mappedBy = "contrat", cascade = CascadeType.ALL)
    @ToString.Exclude
    private List<Paiement> paiements = new java.util.ArrayList<>();

    @Override
    public final boolean equals(Object o) {
        if (this == o) return true;
        if (o == null) return false;
        Class<?> oEffectiveClass = o instanceof HibernateProxy ? ((HibernateProxy) o).getHibernateLazyInitializer().getPersistentClass() : o.getClass();
        Class<?> thisEffectiveClass = this instanceof HibernateProxy ? ((HibernateProxy) this).getHibernateLazyInitializer().getPersistentClass() : this.getClass();
        if (thisEffectiveClass != oEffectiveClass) return false;
        ContratLocation that = (ContratLocation) o;
        return getId() != null && Objects.equals(getId(), that.getId());
    }

    @Override
    public final int hashCode() {
        return this instanceof HibernateProxy ? ((HibernateProxy) this).getHibernateLazyInitializer().getPersistentClass().hashCode() : getClass().hashCode();
    }
}
