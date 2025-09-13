package com.immoplus.app.immoplus.entities;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.proxy.HibernateProxy;

import java.util.Objects;

@Entity
@Table(name = "unitelocation")
@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class UniteLocation {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String titre;

    @Column(name = "nbpieces")
    private int nbPieces;

    private double superficie;
    private double loyer;

    @Column(name = "imagepath")
    private String imagePath;

    // Disponible par défaut pour lister côté locataire
    private boolean available = true;

    @ManyToOne
    @JoinColumn(name = "immeuble_id")
    private Immeuble immeuble;

    @Override
    public final boolean equals(Object o) {
        if (this == o) return true;
        if (o == null) return false;
        Class<?> oEffectiveClass = o instanceof HibernateProxy ? ((HibernateProxy) o).getHibernateLazyInitializer().getPersistentClass() : o.getClass();
        Class<?> thisEffectiveClass = this instanceof HibernateProxy ? ((HibernateProxy) this).getHibernateLazyInitializer().getPersistentClass() : this.getClass();
        if (thisEffectiveClass != oEffectiveClass) return false;
        UniteLocation that = (UniteLocation) o;
        return getId() != null && Objects.equals(getId(), that.getId());
    }

    @Override
    public final int hashCode() {
        return this instanceof HibernateProxy ? ((HibernateProxy) this).getHibernateLazyInitializer().getPersistentClass().hashCode() : getClass().hashCode();
    }
}
