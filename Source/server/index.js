const { ApolloServer, gql } = require('apollo-server');
const { find, filter } = require('lodash');

const typeDefs = gql`
type Query {
  dailyTransactionsFeed: [DailyTransactionWidget],
}

union DailyTransactionWidget = DaySectionWidget | TransactionWidget

type Money {
  value: String! # format: ^((-?[0-9]+)|(-?([0-9]+)?[.][0-9]+))$
  currencyCode: CurrencyCode!
}

type Image {
  iconName: String
  url: String
}

type DaySectionWidget {
  date: String!
  amount: Money!
}

enum CurrencyCode {
  GBP
  RUB
  USD
}

enum TransactionType {
  REGULAR
  CASHBACK
}

type Transaction {
  id: ID!
  title: String!
  amount: Money!
  type: TransactionType!
}

type TransactionWidget {
  transaction: Transaction!
  image: Image
}
`;

const DailyTransactionWidgets = [
    {
        __type: 'DaySectionWidget',
        date: "2019-11-19",
        amount: {
            value: "-123.50",
            currencyCode: "GBP",
        },
    },
    {
        __type: 'TransactionWidget',
        transaction: {
            id: "1",
            title: 'Nando\'s',
            amount: {
                value: '-14.99',
                currencyCode: 'GBP'
            },
            type: 'REGULAR'
        },
        image: {
            iconName: 'restaurant'
        }
    },
    {
        __type: 'TransactionWidget',
        transaction: {
            id: "2",
            title: 'Starbucks',
            amount: {
                value: '20.00',
                currencyCode: 'GBP'
            },
            type: 'CASHBACK'
        },
        image: {
            iconName: 'coffee'
        }
    },
    {
        __type: 'TransactionWidget',
        transaction: {
            id: "3",
            title: 'Starbucks',
            amount: {
                value: '-2.50',
                currencyCode: 'GBP'
            },
            type: 'REGULAR'
        },
        image: {
            iconName: 'coffee'
        }
    },
    {
        __type: 'DaySectionWidget',
        date: "2019-11-18",
        amount: {
            value: "-123.50",
            currencyCode: "GBP",
        },
    },
    {
        __type: 'TransactionWidget',
        transaction: {
            id: "4",
            title: 'Caffe Nero',
            amount: {
                value: '-4.00',
                currencyCode: 'GBP'
            },
            type: 'REGULAR'
        },
        image: {
            iconName: 'coffee'
        }
    },
    {
        __type: 'TransactionWidget',
        transaction: {
            id: "5",
            title: 'The Ned',
            amount: {
                value: '-85.40',
                currencyCode: 'GBP'
            },
            type: 'REGULAR'
        },
        image: {
            iconName: 'restaurant'
        }
    },
    {
        __type: 'TransactionWidget',
        transaction: {
            id: "6",
            title: 'Starbucks',
            amount: {
                value: '-8.00',
                currencyCode: 'GBP'
            },
            type: 'REGULAR'
        },
        image: {
            iconName: 'coffee'
        }
    },
    {
        __type: 'TransactionWidget',
        transaction: {
            id: "7",
            title: 'Starbucks',
            amount: {
                value: '-5.00',
                currencyCode: 'GBP'
            },
            type: 'REGULAR'
        },
        image: {
            iconName: 'coffee'
        }
    },
    {
        __type: 'TransactionWidget',
        transaction: {
            id: "8",
            title: 'Starbucks',
            amount: {
                value: '-2.00',
                currencyCode: 'GBP'
            },
            type: 'REGULAR'
        },
        image: {
            iconName: 'coffee'
        }
    },
    {
        __type: 'DaySectionWidget',
        date: "2019-11-17",
        amount: {
            value: "-123.50",
            currencyCode: "GBP",
        },
    },
    {
        __type: 'TransactionWidget',
        transaction: {
            id: "9",
            title: 'The Ned',
            amount: {
                value: '-85.40',
                currencyCode: 'GBP'
            },
            type: 'REGULAR'
        },
        image: {
            iconName: 'restaurant'
        }
    },
    {
        __type: 'TransactionWidget',
        transaction: {
            id: "10",
            title: 'Starbucks',
            amount: {
                value: '20.00',
                currencyCode: 'GBP'
            },
            type: 'CASHBACK'
        },
        image: {
            iconName: 'coffee'
        }
    },
    {
        __type: 'TransactionWidget',
        transaction: {
            id: "11",
            title: 'Starbucks',
            amount: {
                value: '-5.00',
                currencyCode: 'GBP'
            },
            type: 'REGULAR'
        },
        image: {
            iconName: 'coffee'
        }
    },
    {
        __type: 'TransactionWidget',
        transaction: {
            id: "12",
            title: 'Starbucks',
            amount: {
                value: '-2.00',
                currencyCode: 'GBP'
            },
            type: 'REGULAR'
        },
        image: {
            iconName: 'coffee'
        }
    }
];

const resolvers = {
  DailyTransactionWidget: {
    __resolveType(obj, context, info){
      if (obj.__type == 'DaySectionWidget') {
        return 'DaySectionWidget';
      }
      if (obj.__type == 'TransactionWidget') {
        return 'TransactionWidget';
      }
      return null;
    },
  },
  Query: {
    dailyTransactionsFeed: () => DailyTransactionWidgets,
  },
};

const server = new ApolloServer({ typeDefs, resolvers });

server.listen().then(({ url }) => {
  console.log(`🚀  Server ready at ${url}`);
});
