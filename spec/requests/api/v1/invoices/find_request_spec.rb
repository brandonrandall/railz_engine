require 'rails_helper'

RSpec.describe "Invoices find API" do
  describe "Invoice params returns single record" do
    it "can find invoice by id" do
      invoices = create_list(:invoice, 3)

      get "/api/v1/invoices/find?id=#{invoices.first.id}"

      expect(response).to be_success

      invoice = JSON.parse(response.body)

      expect(invoice["id"]).to eq(invoices.first.id)
    end

    it "can find invoice by status" do
      invoices = create_list(:invoice, 3)

      get "/api/v1/invoices/find?status=#{invoices.first.status}"

      expect(response).to be_success

      invoice = JSON.parse(response.body)

      expect(invoice["id"]).to eq(invoices.first.id)
    end

    it "can find invoice by created at" do
      invoices = create_list(:invoice, 3)

      get "/api/v1/invoices/find?created_at=#{invoices.first.created_at}"

      expect(response).to be_success

      invoice = JSON.parse(response.body)

      expect(invoice["id"]).to eq(invoices.first.id)
    end

    it "can find invoice by updated at" do
      invoices = create_list(:invoice, 3)

      get "/api/v1/invoices/find?updated_at=#{invoices.first.updated_at}"

      expect(response).to be_success

      invoice = JSON.parse(response.body)

      expect(invoice["id"]).to eq(invoices.first.id)
    end
  end

  describe "Invoice params return multiple records" do
    it "can find all invoices by id" do
      invoices = create_list(:invoice, 3)

      get "/api/v1/invoices/find_all?id=#{invoices.first.id}"

      expect(response).to be_success

      invoice = JSON.parse(response.body)

      expect(invoice.first["id"]).to eq(invoices.first.id)
    end

    xit "can find all invoices by status" do
      create(:merchant, id: 1)
      create(:customer, id: 1)
      invoice1 = Invoice.create(status: "shipped", created_at: "2017-05-01 18:06:59", updated_at: "2017-05-01 18:06:59", customer_id: 1, merchant_id: 1)
      invoice2 = Invoice.create(status: "shipped", created_at: "2017-05-01 18:06:59", updated_at: "2017-05-01 18:06:59", customer_id: 1, merchant_id: 1)
      invoice3 = Invoice.create(status: "ordered", created_at: "2017-05-01 18:06:59", updated_at: "2017-05-01 18:06:59", customer_id: 1, merchant_id: 1)


      get "/api/v1/invoices/find_all?status=#{invoice1.status}"

      expect(response).to be_success

      invoices = JSON.parse(response.body)

      expect(invoices.count).to eq(2)

      get "/api/v1/invoices/find_all?status=#{invoice1.status.upcase}"

      expect(response).to be_success

      invoices = JSON.parse(response.body)

      expect(invoices.count).to eq(2)
    end

    xit "can find all invoices by created_at" do
      create(:merchant, id: 1)
      create(:customer, id: 1)
      invoice1 = Invoice.create(status: "shipped", created_at: "2017-05-01 18:06:59", updated_at: "2017-05-01 18:06:59", customer_id: 1, merchant_id: 1)
      invoice2 = Invoice.create(status: "shipped", created_at: "2017-05-01 18:06:59", updated_at: "2017-05-01 18:06:59", customer_id: 1, merchant_id: 1)
      invoice3 = Invoice.create(status: "ordered", created_at: "2017-05-02 18:06:59", updated_at: "2017-05-01 18:06:59", customer_id: 1, merchant_id: 1)

      get "/api/v1/invoices/find_all?created_at=#{invoice1.created_at}"

      expect(response).to be_success

      invoices = JSON.parse(response.body)

      expect(invoices.count).to eq(2)
      expect(invoices.first["id"]).to eq(invoice1.id)
    end

    xit "can find all invoices by updated at" do
      create(:merchant, id: 1)
      create(:customer, id: 1)
      invoice1 = Invoice.create(status: "shipped", created_at: "2017-05-01 18:06:59", updated_at: "2017-05-01 18:06:59", customer_id: 1, merchant_id: 1)
      invoice2 = Invoice.create(status: "shipped", created_at: "2017-05-01 18:06:59", updated_at: "2017-05-02 18:06:59", customer_id: 1, merchant_id: 1)
      invoice3 = Invoice.create(status: "ordered", created_at: "2017-05-02 18:06:59", updated_at: "2017-05-02 18:06:59", customer_id: 1, merchant_id: 1)
      get "/api/v1/invoices/find_all?updated_at=#{invoice2.updated_at}"

      expect(response).to be_success

      invoices = JSON.parse(response.body)

      expect(invoices.count).to eq(2)
      expect(invoices.first["id"]).to eq(invoice2.id)
    end
  end
end
