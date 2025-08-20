package com.github.av2.api.data;

import com.github.av2.api.model.*;
import org.springframework.stereotype.Component;
import jakarta.annotation.PostConstruct;
import java.util.*;

@Component
public class SeedData {
    private final List<Supplier> suppliers = new ArrayList<>();
    private final List<Product> products = new ArrayList<>();
    private final List<Headquarters> headquarters = new ArrayList<>();
    private final List<Branch> branches = new ArrayList<>();
    private final List<Order> orders = new ArrayList<>();
    private final List<OrderDetail> orderDetails = new ArrayList<>();
    private final List<Delivery> deliveries = new ArrayList<>();
    private final List<OrderDetailDelivery> orderDetailDeliveries = new ArrayList<>();

    @PostConstruct
    public void init() {
        initSuppliers();
        initProducts();
        initHeadquarters();
        initBranches();
        initOrders();
        initOrderDetails();
        initDeliveries();
        initOrderDetailDeliveries();
    }

    private void initSuppliers() {
        suppliers.add(new Supplier(1, "PurrTech Innovations", "Leading supplier of premium smart cat technology", 
            "Felix Whiskerton", "felix@purrtech.co", "555-0101"));
        suppliers.add(new Supplier(2, "WhiskerWare Systems", "Advanced feline-focused smart product supplier", 
            "Tabitha Pawson", "tabitha@whiskerware.com", "555-0102"));
        suppliers.add(new Supplier(3, "CatNip Creations", "Supplier of eco-friendly cat toys and accessories", 
            "Nina Nibbles", "nina@catnip.com", "555-0103"));
    }

    private void initProducts() {
        products.add(new Product(1, 3, "SmartFeeder One", "This AI-powered feeder learns your cat's snack schedule based on nap cycles and mealtime habits. It detects overeating, undernapping, and auto-updates a Feline Health Repo.",
            129.99f, "CAT-FEED-001", "piece", "feeder.png", 0.25f));
        products.add(new Product(2, 3, "AutoClean Litter Dome", "A self-cleaning litter box that detects patterns in your cat's... commits. Sends you a health report and Slack alert if things look off.",
            199.99f, "CAT-LITTER-001", "piece", "litter-box.png", 0.25f));
        products.add(new Product(3, 2, "CatFlix Entertainment Portal", "On-demand laser shows, motion videos, and bird-watching streams - customized per cat using AI interest tracking. Think Netflix, but for felines.",
            89.99f, "CAT-FLIX-001", "piece", "catflix.png", null));
        products.add(new Product(4, 2, "PawTrack Smart Collar", "GPS and activity tracker with AI-powered mood detection based on tail position, purring frequency, and movement patterns. Syncs with your phone for walk stats and zoomie alerts.",
            79.99f, "CAT-COLLAR-001", "piece", "smart-collar.png", null));
        products.add(new Product(5, 1, "SleepNest ThermoPod", "A smart bed that adjusts its temperature, lighting, and white noise based on your cat's REM cycles. Auto-generates nap metrics in JSON.",
            149.99f, "CAT-BED-001", "piece", "sleep-nest.png", null));
        products.add(new Product(6, 1, "ClawMate Auto Groomer", "Your cat brushes itself. This AI station detects which areas need grooming, dispenses treats for patience, and logs grooming history to your pet portal.",
            119.99f, "CAT-GROOM-001", "piece", "auto-groomer.png", null));
        products.add(new Product(7, 3, "Smart Fountain Flow+", "This water fountain adjusts flow patterns based on time of day, cat hydration levels, and even playfulness. Uses facial recognition to distinguish multiple cats.",
            69.99f, "CAT-FOUNTAIN-001", "piece", "smart-fountain.png", 0.25f));
        products.add(new Product(8, 2, "ScratchPad Pro", "More than a scratcher - this one detects scratching habits, gamifies it with leaderboard stats for multi-cat homes, and awards digital badges.",
            59.99f, "CAT-SCRATCH-001", "piece", "scratch-pad.png", null));
        products.add(new Product(9, 2, "ChirpCam Window Mount", "Motion-activated smart cam that records wildlife outside the window and sends curated 'Birdflix' highlights to your cat's personal feed.",
            99.99f, "CAT-CAM-001", "piece", "chirp-cam.png", null));
        products.add(new Product(10, 3, "SnackVault Puzzle Dispenser", "Treat puzzle toy that evolves in difficulty with your cat's cleverness. AI engine auto-adjusts pathways and provides tips to the human if the cat cheats.",
            49.99f, "CAT-SNACK-001", "piece", "snack-vault.png", 0.25f));
        products.add(new Product(11, 1, "DoorDash Pet Portal", "Smart cat door with facial recognition and time-based access. Prevents midnight squirrel parties and tracks in/out commits to your dashboard.",
            159.99f, "CAT-DOOR-001", "piece", "door-dash.png", null));
        products.add(new Product(12, 2, "ZoomieTracker AI Mat", "A motion-sensing mat that detects zoomies, spins up chase lights, and logs agility bursts to a weekly health report. Yes, it graphs zoomies per hour.",
            79.99f, "CAT-TRACKER-001", "piece", "tracker-mat.png", null));
    }

    private void initHeadquarters() {
        headquarters.add(new Headquarters(1, "CatTech Global HQ", "Feline tech innovations headquarters",
            "123 Whisker Lane, Purrington District", "Catherine Purrston", "catherine@octocat.com", "555-0001"));
    }

    private void initBranches() {
        branches.add(new Branch(1, 1, "Meowtown Branch", "Main downtown cat tech showroom",
            "456 Purrfect Plaza", "Chloe Whiskers", "cwhiskers@octocat.com", "555-0201"));
        branches.add(new Branch(2, 1, "Tabby Terrace Branch", "Western district cat tech hub",
            "789 Feline Avenue", "Tom Pouncer", "tpouncer@octocat.com", "555-0202"));
    }

    private void initOrders() {
        String now = new Date().toString();
        orders.add(new Order(1, 1, now, "Q2 Feline Tech Refresh", "Quarterly smart cat tech product refresh", "pending"));
        orders.add(new Order(2, 2, now, "Cat Enrichment Bundle", "Monthly cat entertainment systems restock", "processing"));
    }

    private void initOrderDetails() {
        orderDetails.add(new OrderDetail(1, 1, 2, 5, 199.99f, "AutoClean Litter Domes for new cat café locations"));
        orderDetails.add(new OrderDetail(2, 1, 3, 5, 89.99f, "CatFlix Entertainment Portals for waiting areas"));
        orderDetails.add(new OrderDetail(3, 2, 4, 20, 79.99f, "PawTrack Smart Collars for adoption events"));
    }

    private void initDeliveries() {
        String date1 = new Date(System.currentTimeMillis() + 7 * 24 * 60 * 60 * 1000).toString();
        String date2 = new Date(System.currentTimeMillis() + 2 * 24 * 60 * 60 * 1000).toString();
        
        deliveries.add(new Delivery(1, 1, date1, "PurrTech Smart Home Bundle", "Premium cat tech products delivery for smart cat homes", "pending"));
        deliveries.add(new Delivery(2, 2, date2, "WhiskerWare Entertainment Package", "Entertainment and tracking systems for feline companions", "in-transit"));
    }

    private void initOrderDetailDeliveries() {
        orderDetailDeliveries.add(new OrderDetailDelivery(1, 1, 1, 5, "Delivery batch"));
        orderDetailDeliveries.add(new OrderDetailDelivery(2, 2, 1, 5, "Delivery batch"));
        orderDetailDeliveries.add(new OrderDetailDelivery(3, 3, 2, 20, "Delivery"));
    }

    // Getters for the collections
    public List<Supplier> getSuppliers() { return new ArrayList<>(suppliers); }
    public List<Product> getProducts() { return new ArrayList<>(products); }
    public List<Headquarters> getHeadquarters() { return new ArrayList<>(headquarters); }
    public List<Branch> getBranches() { return new ArrayList<>(branches); }
    public List<Order> getOrders() { return new ArrayList<>(orders); }
    public List<OrderDetail> getOrderDetails() { return new ArrayList<>(orderDetails); }
    public List<Delivery> getDeliveries() { return new ArrayList<>(deliveries); }
    public List<OrderDetailDelivery> getOrderDetailDeliveries() { return new ArrayList<>(orderDetailDeliveries); }
}