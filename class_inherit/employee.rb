# Learning Goals

# Understand how a subclass inherits from a superclass
# Know how to override a parent class's method
# Know when and how to use super

# Employee and Manager

class Employee
    attr_reader :salary

# Write a class Employee that has attributes that return the employee's name,
# title, salary, and boss.  
    def initialize(name, salary, title, boss = nil)
        @name = name
        @salary = salary
        @title = title
        @boss = boss
    end 
    
# Add a method, bonus(multiplier) to Employee. Non-manager employees should get
# a bonus like this
# bonus = (employee salary) * multiplier

    def bonus(multiplier)
        @salary * multiplier
    end 
    
    def inspect
        @name
    end

end 

class Manager < Employee
# Write another class, Manager, that extends Employee. Manager should have an
# attribute that holds an array of all employees assigned to the manager. Note
# that managers might report to higher level managers, of course.
    attr_reader :subordinates

    def initialize(name, salary, title, boss = nil) 
        super  
        @subordinates = []
    end
    
    def add_subordinates(sub)
        @subordinates << sub
    end 
# Managers should get a bonus based on the total salary of all of their
# subordinates, as well as the manager's subordinates' subordinates, and the
# subordinates' subordinates' subordinates, etc.
    def bonus(multiplier)
        total_salary_employees * multiplier
    end 

    def total_salary_employees
        total = 0
        @subordinates.each do |person|
            if person.is_a?(Manager) 
                total+= (person.salary + person.total_salary_employees)
            else
                total+= person.salary
            end 
        end 
        total
    end 

# bonus = (total salary of all sub-employees) * multiplier

end

# Testing
# If we have a company structured like this:

# Name	    Salary	           Title	        Boss
# Ned	    \$1,000,000	       Founder	        nil
# Darren	\$78,000	       TA Manager	    Ned
# Shawna	\$12,000	       TA	            Darren
# David	    \$10,000	       TA	            Darren

# ned.bonus(5) # => 500_000
# darren.bonus(4) # => 88_000
# david.bonus(3) # => 30_000

# p ned = Manager.new("ned", 1000000, "Founder")

# darren = Manager.new("darren", 78000, "TA Manager", ned)

# shawna =  Employee.new("shawna", 12000, "TA", darren)

# david =  Employee.new("david", 10000, "TA", darren)
    