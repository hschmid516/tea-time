# Tea Time

Tea Time was created as a practice take-home project for Turing School of Software and Design. It is a REST API built in rails as a Tea Subscription Service. There are three endpoints exposed for subscribing customers to a tea subscription, cancelling or reactivating a subscription, and viewing all subscriptions for a customer.


## Built With
#### Framework
<p>
  <img src="https://img.shields.io/badge/Ruby%20On%20Rails-b81818.svg?&style=flat&logo=rubyonrails&logoColor=white" />
</p>

#### Languages
<p>
  <img src="https://img.shields.io/badge/Ruby-CC0000.svg?&style=flaste&logo=ruby&logoColor=white" />
  <img src="https://img.shields.io/badge/ActiveRecord-CC0000.svg?&style=flaste&logo=rubyonrails&logoColor=white" />
</p>

#### Tools
<p>
  <img src="https://img.shields.io/badge/Atom-66595C.svg?&style=flaste&logo=atom&logoColor=white" />
  <img src="https://img.shields.io/badge/Git-F05032.svg?&style=flaste&logo=git&logoColor=white" />
  <img src="https://img.shields.io/badge/GitHub-181717.svg?&style=flaste&logo=github&logoColor=white" />
  <img src="https://img.shields.io/badge/PostgreSQL-4169E1.svg?&style=flaste&logo=postgresql&logoColor=white" />
  <img src="https://img.shields.io/badge/Postman-f74114.svg?&style=flat&logo=postman&logoColor=white" />

</p>

#### Gems
<p>
  <img src="https://img.shields.io/badge/rspec-b81818.svg?&style=flaste&logo=rubygems&logoColor=white" />
  <img src="https://img.shields.io/badge/pry-b81818.svg?&style=flaste&logo=rubygems&logoColor=white" />  
  <img src="https://img.shields.io/badge/simplecov-b81818.svg?&style=flaste&logo=rubygems&logoColor=white" />  
  <img src="https://img.shields.io/badge/faker-b81818.svg?&style=flaste&logo=rubygems&logoColor=white" />
  <img src="https://img.shields.io/badge/rubocop-b81818.svg?&style=flaste&logo=rubygems&logoColor=white" />
  <img src="https://img.shields.io/badge/shoulda--matchers-b81818.svg?&style=flaste&logo=rubygems&logoColor=white" /></br>
  <img src="https://img.shields.io/badge/capybara-b81818.svg?&style=flaste&logo=rubygems&logoColor=white" />
  <img src="https://img.shields.io/badge/factory--bot-b81818.svg?&style=flaste&logo=rubygems&logoColor=white" />
  <img src="https://img.shields.io/badge/json_api_serializer-b81818.svg?&style=flaste&logo=rubygems&logoColor=white" />
</p>

#### Development Principles
<p>
  <img src="https://img.shields.io/badge/OOP-b81818.svg?&style=flaste&logo=OOP&logoColor=white" />
  <img src="https://img.shields.io/badge/TDD-b87818.svg?&style=flaste&logo=TDD&logoColor=white" />
  <img src="https://img.shields.io/badge/MVC-b8b018.svg?&style=flaste&logo=MVC&logoColor=white" />
  <img src="https://img.shields.io/badge/REST-33b818.svg?&style=flaste&logo=REST&logoColor=white" />
</p>


## Installation

1. Clone the repo
   ```sh
   git clone git@github.com/hschmid516/tea-time.git
   ```
3. Run bundle
   ```sh
   bundle install
   ```
4. Run migrations
   ```sh
   rails db:{create,migrate,seed}
   ```
5. Run tests
   ```sh
   bundle exec rspec
   ```

## Database Schema Design
<img src="https://user-images.githubusercontent.com/78242081/148468903-d9d117f8-2f30-4f1c-9c89-c89e21d83be0.png" alt="drawing" width="500"/>

## Endpoints
### Create a tea subscription for a customer
`POST /api/v1/customers/:customer_id/subscriptions`

**Example Request Body:**

```json
{      
  "customer_id": 9,
  "tea_id": 72,
  "title": "Super Cool Tea",
  "price": 7.25,
  "status": "active",
  "frequency": "weekly"
}
```

**Example Response:**

```json
{
    "data": {
        "id": "31",
        "type": "subscription",
        "attributes": {
            "customer_id": 9,
            "tea_id": 72,
            "title": "Super Cool Tea",
            "price": 7.25,
            "status": "active",
            "frequency": "weekly"
        }
    }
}
```

### Cancel or Reactivate a Subscription
 `PATCH /api/v1/customers/:customer_id/subscriptions/subscription_id?status={status}`

`status` can either be `0` for `active`, or `1` for `cancelled`

**Example Response:**

```json
{
    "data": {
        "id": "31",
        "type": "subscription",
        "attributes": {
            "customer_id": 9,
            "tea_id": 72,
            "title": "Super Cool Tea",
            "price": 7.25,
            "status": "cancelled",
            "frequency": "weekly"
        }
    }
}
```

### Cancel or Reactivate a Subscription
 `GET /api/v1/customers/:customer_id/subscriptions`

**Example Response:**

```json
{
    "data": [
        {
            "id": "11",
            "type": "subscription",
            "attributes": {
                "customer_id": 9,
                "tea_id": 71,
                "title": "My Yi Zhen Bai Hao Subscription",
                "price": 10.50,
                "status": "cancelled",
                "frequency": "weekly"
            }
        },
        {
            "id": "12",
            "type": "subscription",
            "attributes": {
                "customer_id": 9,
                "tea_id": 72,
                "title": "My Tieluohan Subscription",
                "price": 7.25,
                "status": "active",
                "frequency": "monthly"
            }
        },
        {
            "id": "13",
            "type": "subscription",
            "attributes": {
                "customer_id": 9,
                "tea_id": 73,
                "title": "My Fujian New Craft Subscription",
                "price": 9.00,
                "status": "cancelled",
                "frequency": "monthly"
            }
        }
      ]
}
```


## Contact

<p>
  <img src="https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white" />
</p>

- [Henry Schmid](https://www.linkedin.com/in/henry-schmid)


<p>
  <img src="https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white" />
</p>

- [Henry Schmid](https://github.com/hschmid516)



<p align="right">(<a href="#top">back to top</a>)</p>
