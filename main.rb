class TaxCalculator
    TAX_BRACKET = [[20000, 0], [40000, 0.1], [80000, 0.2], [180000, 0.3], [Float::INFINITY, 0.4]]
  
    def initialize(annual_salary)
      @annual_salary = annual_salary
    end
  
    def tax
      calc_tax(@annual_salary)
    end
  
    private
  
    def calc_tax(income)
      total_tax = 0
      last_amount = 0
  
      TAX_BRACKET.each do |amount, tax_rate|
        if income < amount
          total_tax += (income - last_amount) * tax_rate
          break
        else
          total_tax += (amount - last_amount) * tax_rate
          last_amount = amount
        end
      end
  
      total_tax
    end
  end
  
  class Employee
    attr_reader :name, :annual_salary, :gross_monthly_income, :monthly_tax, :net_monthly_income
  
    def initialize(name, annual_salary)
      @name = name
      @annual_salary = annual_salary
    end
  
    def generate_monthly_payslip
      @gross_monthly_income = (@annual_salary / 12.0).round(2)
      @monthly_tax = (TaxCalculator.new(annual_salary).tax / 12.0).round(2)
      @net_monthly_income = (@gross_monthly_income - @monthly_tax).round(2)

      print_employee_details      
    end

    private
    def print_employee_details
      puts "Monthly Payslip for: #{@name}"
      puts "Gross Monthly Income: $#{sprintf('%.2f',@gross_monthly_income)}"
      puts "Monthly Income Tax: $#{sprintf('%.2f',@monthly_tax)}"
      puts "Net Monthly Income: $#{sprintf('%.2f',@net_monthly_income)}"
    end
  end
  
  Employee.new("Ren", 60000).generate_monthly_payslip
  Employee.new("Jack", 200000).generate_monthly_payslip
  Employee.new("Mark", 80150).generate_monthly_payslip
  