#include <iostream>

template<typename T>
concept PricedItem = requires(T t) {
    { t.getCoefficient() } -> std::same_as<double>;
    { t.getBasePrice() } -> std::same_as<double>;
};

template<size_t PRIORITY>
class PricePresenter {
public:
    template<PricedItem T1, PricedItem T2>
    void printTotalPrice(const T1& obj1, const T2& obj2) const {
        double totalPrice = PRIORITY * obj1.getCoefficient() * obj1.getBasePrice() +
                            obj2.getCoefficient() * obj2.getBasePrice();
        std::cout << "Total Price: " << totalPrice << std::endl;
    }
};

class Milk {
public:
    double getCoefficient() const {
        return 1.2;
    }

    double getBasePrice() const {
        return 3.5;
    }
};

class Cookies {
public:
    double getCoefficient() const {
        return 1.5;
    }

    double getBasePrice() const {
        return 4.0;
    }
};

class Pineapple {
public:
    double getCoefficient() const {
        return 2.0;
    }

    double getBasePrice() const {
        return 5.5;
    }
};

int main() {
    PricePresenter<2> presenter;

    Milk milk;
    Cookies cookies;
    Pineapple pineapple;

    presenter.printTotalPrice(milk, cookies);  
    presenter.printTotalPrice(cookies, pineapple); 
    presenter.printTotalPrice(milk, pineapple);  

    return 0;
}
