package com.pitstop.mechanic.domain;

import javax.persistence.*;
import java.util.UUID;

@Entity
public class Mechanic {

    @Id
    @GeneratedValue
    private UUID id;

    private String name;

    /**
     * Mechanic skill type. Example values: TYRE, BATTERY, ENGINE.
     */
    private String skill;

    /**
     * Mechanic location latitude.
     */
    private double lat;

    /**
     * Mechanic location longitude.
     */
    private double lng;

    public Mechanic() {
    }

    public Mechanic(UUID id, String name, String skill, double lat, double lng) {
        this.id = id;
        this.name = name;
        this.skill = skill;
        this.lat = lat;
        this.lng = lng;
    }

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSkill() {
        return skill;
    }

    public void setSkill(String skill) {
        this.skill = skill;
    }

    public double getLat() {
        return lat;
    }

    public void setLat(double lat) {
        this.lat = lat;
    }

    public double getLng() {
        return lng;
    }

    public void setLng(double lng) {
        this.lng = lng;
    }

    @Override
    public String toString() {
        return "Mechanic{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", skill='" + skill + '\'' +
                ", lat=" + lat +
                ", lng=" + lng +
                '}';
    }
}
