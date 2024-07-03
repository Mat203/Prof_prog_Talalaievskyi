#pragma once

#include "ModernCalculators.hpp"
#include "LegacyCalculator.hpp"
#include <memory>
#include <string>

class MegaAdapter : public BaseMegaCalculator {
public:
    MegaAdapter(std::unique_ptr<LegacyCalculator> legacyCalc)
        : legacyCalculator(std::move(legacyCalc)) {}

    double getPrice() const override {
        return legacyCalculator->calculatePricePart1() + legacyCalculator->calculatePricePart2();
    }

    double getMinimalValue() const override {
        return legacyCalculator->getOurTheMostAndMinimalValue();
    }

    std::string getReport() const override {
        return legacyCalculator->getSomeDocumentRepresentation();
    }

private:
    std::unique_ptr<LegacyCalculator> legacyCalculator;
};
