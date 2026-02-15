#include <iomanip>
#include <iostream>
#include <memory>
#include <string>
#include <vector>

class Ride
{
public:
    Ride(int rideId,
         std::string pickup,
         std::string dropoff,
         double distanceMiles)
        : rideId_(rideId),
          pickup_(std::move(pickup)),
          dropoff_(std::move(dropoff)),
          distanceMiles_(distanceMiles) {}

    virtual ~Ride() = default;

    int getRideId() const
    {
        return rideId_;
    }

    double getDistanceMiles() const
    {
        return distanceMiles_;
    }

    virtual double fare() const = 0;

    virtual void rideDetails() const
    {
        std::cout << "Ride ID: " << rideId_ << "\n"
                  << "Pickup: " << pickup_ << "\n"
                  << "Dropoff: " << dropoff_ << "\n"
                  << "Distance: " << std::fixed << std::setprecision(2)
                  << distanceMiles_ << " miles\n";
    }

private:
    int rideId_;
    std::string pickup_;
    std::string dropoff_;
    double distanceMiles_;
};

class StandardRide : public Ride
{
public:
    StandardRide(int rideId,
                 std::string pickup,
                 std::string dropoff,
                 double distanceMiles)
        : Ride(rideId, std::move(pickup), std::move(dropoff), distanceMiles) {}

    double fare() const override
    {
        const double baseFare = 2.50;
        const double perMile = 1.25;
        return baseFare + (perMile * getDistanceMiles());
    }

    void rideDetails() const override
    {
        std::cout << "Ride Type: Standard\n";
        Ride::rideDetails();
        std::cout << "Fare: $" << std::fixed << std::setprecision(2) << fare()
                  << "\n";
    }
};

class PremiumRide : public Ride
{
public:
    PremiumRide(int rideId,
                std::string pickup,
                std::string dropoff,
                double distanceMiles)
        : Ride(rideId, std::move(pickup), std::move(dropoff), distanceMiles) {}

    double fare() const override
    {
        const double baseFare = 5.00;
        const double perMile = 2.25;
        return baseFare + (perMile * getDistanceMiles());
    }

    void rideDetails() const override
    {
        std::cout << "Ride Type: Premium\n";
        Ride::rideDetails();
        std::cout << "Fare: $" << std::fixed << std::setprecision(2) << fare()
                  << "\n";
    }
};

class Driver
{
public:
    Driver(int driverId, std::string name, double rating)
        : driverId_(driverId), name_(std::move(name)), rating_(rating) {}

    void addRide(const std::shared_ptr<Ride> &ride)
    {
        assignedRides_.push_back(ride);
    }

    void getDriverInfo() const
    {
        std::cout << "Driver ID: " << driverId_ << "\n"
                  << "Name: " << name_ << "\n"
                  << "Rating: " << std::fixed << std::setprecision(1) << rating_
                  << "\n"
                  << "Assigned rides: " << assignedRides_.size() << "\n";
    }

    void printRideHistory() const
    {
        if (assignedRides_.empty())
        {
            std::cout << "No rides assigned.\n";
            return;
        }

        for (const auto &ride : assignedRides_)
        {
            std::cout << "\n";
            ride->rideDetails();
        }
    }

private:
    int driverId_;
    std::string name_;
    double rating_;
    std::vector<std::shared_ptr<Ride>> assignedRides_;
};

class Rider
{
public:
    Rider(int riderId, std::string name)
        : riderId_(riderId), name_(std::move(name)) {}

    void requestRide(const std::shared_ptr<Ride> &ride)
    {
        requestedRides_.push_back(ride);
    }

    void viewRides() const
    {
        std::cout << "Rider ID: " << riderId_ << "\n"
                  << "Name: " << name_ << "\n";

        if (requestedRides_.empty())
        {
            std::cout << "No rides requested.\n";
            return;
        }

        for (const auto &ride : requestedRides_)
        {
            std::cout << "\n";
            ride->rideDetails();
        }
    }

private:
    int riderId_;
    std::string name_;
    std::vector<std::shared_ptr<Ride>> requestedRides_;
};

int main()
{
    std::shared_ptr<Ride> ride1 = std::make_shared<StandardRide>(
        101, "Campus Library", "Downtown Plaza", 4.2);
    std::shared_ptr<Ride> ride2 = std::make_shared<PremiumRide>(
        202, "Tech Park", "Airport Terminal", 12.8);

    std::vector<std::shared_ptr<Ride>> rides = {ride1, ride2};

    std::cout << "--- Ride Details (Polymorphic Calls) ---\n";
    for (const auto &ride : rides)
    {
        ride->rideDetails();
        std::cout << "\n";
    }

    Driver driver(11, "Jordan Lee", 4.9);
    driver.addRide(ride1);
    driver.addRide(ride2);

    std::cout << "\n--- Driver Info ---\n";
    driver.getDriverInfo();
    std::cout << "\n\n--- Driver Ride History ---\n";
    driver.printRideHistory();

    Rider rider(501, "Avery Patel");
    rider.requestRide(ride1);

    std::cout << "\n\n--- Rider Ride History ---\n";
    rider.viewRides();

    return 0;
}
