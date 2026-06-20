package com.financial.forecast;

public class FinancialForecast {

    public static double predictFutureValue(double currentValue,
                                            double growthRate,
                                            int years) {

        // Base Case
        if (years == 0) {
            return currentValue;
        }

        // Calculate value for next year
        double nextYearValue = currentValue * (1 + growthRate);

        // Recursive Call
        return predictFutureValue(nextYearValue,
                                  growthRate,
                                  years - 1);
    }

    public static void main(String[] args) {

        double initialInvestment = 10000;

        double annualGrowthRate = 0.10;

        int forecastYears = 5;

        double futureValue =
                predictFutureValue(initialInvestment,
                                   annualGrowthRate,
                                   forecastYears);

        System.out.println("Initial Investment: ₹"
                + initialInvestment);

        System.out.println("Growth Rate: "
                + (annualGrowthRate * 100) + "%");

        System.out.println("Forecast Period: "
                + forecastYears + " years");

        System.out.printf("Predicted Future Value: ₹%.2f",
                futureValue);
    }
}