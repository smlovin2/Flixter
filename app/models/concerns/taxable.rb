module Taxable
  extend ActiveSupport::Concern


  def taxed_cost(tax_rate)
    tax_rate = normalized_tax_rate(tax_rate)
    (cost * tax_rate).round(2)
  end

  private

  # Accepts:
  # 0.00 - 0.99
  # 1.00 - 1.99
  # 2+
  def normalized_tax_rate(tax_rate)
    if tax_rate >= 2
      tax_rate = tax_rate / 100.0
    end

    if tax_rate < 1
      tax_rate += 1
    end

    tax_rate
  end

end
