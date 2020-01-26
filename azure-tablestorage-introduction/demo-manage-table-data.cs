using System;
using System.Threading.Tasks;
using Microsoft.Azure.Cosmos.Table;
// Add library by running command
// dotnet add package Microsoft.Azure.Cosmos.Table --version 1.0.6

namespace demo
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Table storage sample");

            var storageConnectionString = "";
            var tableName = "";

            CloudStorageAccount storageAccount;
            storageAccount = CloudStorageAccount.Parse(storageConnectionString);

            CloudTableClient tableClient = storageAccount.CreateCloudTableClient(new TableClientConfiguration());
            CloudTable table = tableClient.GetTableReference(tableName);


            CustomerEntity customer = new CustomerEntity("Harp", "Walter")
            {
                Email = "Walter@contoso.com",
                PhoneNumber = "425-555-0101"
            };

            MergeUser(table, customer).Wait();
            QueryUser(table, "Harp", "Walter").Wait();

        }

        public static async Task MergeUser(CloudTable table, CustomerEntity customer) {
            TableOperation insertOrMergeOperation = TableOperation.InsertOrMerge(customer);

            // Execute the operation.
            TableResult result = await table.ExecuteAsync(insertOrMergeOperation);
            CustomerEntity insertedCustomer = result.Result as CustomerEntity;

            Console.WriteLine("Added user.");
        }

        public static async Task QueryUser(CloudTable table, string firstName, string lastName) {
            TableOperation retrieveOperation = TableOperation.Retrieve<CustomerEntity>(firstName, lastName);
            
            TableResult result = await table.ExecuteAsync(retrieveOperation);
            CustomerEntity customer = result.Result as CustomerEntity;

            if (customer != null)
            {
                Console.WriteLine("Fetched \t{0}\t{1}\t{2}\t{3}", 
                    customer.PartitionKey, customer.RowKey, customer.Email, customer.PhoneNumber);
            }
        }
    }

    public class CustomerEntity : TableEntity
    {
        public CustomerEntity() {}
        public CustomerEntity(string lastName, string firstName)
        {
            PartitionKey = lastName;
            RowKey = firstName;
        }

        public string Email { get; set; }
        public string PhoneNumber { get; set; }
    }
}