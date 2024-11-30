AfroRoot/
├── .github/                             # CI/CD Configurations
│   └── workflows/
│       ├── backend.yml                  # CI for backend services
│       ├── frontend.yml                 # CI for frontend apps
│       ├── blockchain.yml               # CI for blockchain services
│       └── admin-dashboard.yml          # CI for admin dashboard
│       └── code-security.yml               # CI for code security checks (Semgrep)
├── .husky/                              # Git hooks
│   ├── pre-commit                       # Pre-commit hook for linting and testing
│   └── commit-msg                       # Commit message validation
├── packages/                            # Shared packages and configurations
│   ├── shared/                         # Shared components, hooks, services across apps
│   │   ├── components/                  # Shared UI components across apps
│   │   ├── utils/                       # Shared utility functions (formatting, validation, etc.)
│   │   ├── hooks/                       # Shared custom hooks
│   │   ├── types/                       # Shared TypeScript types
│   │   └── constants/                   # Shared constants (e.g., roles, status codes)
│   └── config/                         # Shared configurations (ESLint, Prettier, TypeScript)
│       ├── eslint/                      # ESLint configuration for code linting
│       └── tsconfig/                    # TypeScript configuration
├── centralized-services/                # Centralized services used by multiple apps
│   ├── auth-service/                    # Authentication microservice
│   │   ├── src/                        # Source code for auth-service
│   │   │   ├── controllers/             # Handles user authentication, token management
│   │  │    │   ├── keycloak.js      # Keycloak integration
│   │   │   ├── services/                # Business logic for auth (JWT, OAuth, etc.)
│   │   │   ├── middlewares/             # Auth-related middlewares (e.g., token validation)
│   │  │    │   ├── keycloakAuth.js  # Middleware to handle Keycloak authentication
│   │   │   └── routes/                  # API routes for authentication
│   │   ├── config/                      # Config files for JWT, OAuth, etc.
│   │   │    ├── keycloak.json        # Keycloak server configuration
│   │   ├── tests/                       # Unit and integration tests for auth-service
│   │   ├── .env                         # Environment variables for the auth service
│   │   └── Dockerfile                   # Dockerfile for auth-service
│   ├── payment-service/                 # Payment processing microservice
│   │   ├── src/                       # Source code for payment-service
│   │   │   ├── controllers/             # Handles payment processing (e.g., Stripe, PayPal)
│   │   │   ├── services/                # Payment business logic (e.g., recurring payments)
│   │   │   ├── middlewares/             # Payment-related middlewares (e.g., validation)
│   │   │   └── routes/                  # API routes for payment handling
│   │   ├── config/                      # Config files for payment gateways
│   │   ├── tests/                       # Unit and integration tests for payment-service
│   │   ├── .env                         # Environment variables for the payment service
│   │   └── Dockerfile                   # Dockerfile for payment-service
│   ├── notification-service/            # Notifications microservice
│   │   ├── src/                       # Source code for notification-service
│   │   │   ├── controllers/             # Handles sending notifications (e.g., email, SMS)
│   │   │   ├── services/                # Notification business logic
│   │   │   ├── middlewares/             # Middleware for notification triggers
│   │   │   └── routes/                  # API routes for sending notifications
│   │   ├── config/                      # Config files for email/SMS providers
│   │   ├── tests/                       # Unit and integration tests for notification-service
│   │   ├── .env                         # Environment variables for notification service
│   │   └── Dockerfile                   # Dockerfile for notification-service
├── backend/                             # Backend microservices and API
│   ├── src/                           # Source code for backend services
│   │   ├── api/                      # API services for frontend apps
│   │   │   ├── graphql/                 # GraphQL APIs for interacting with frontend
│   │   │   │   ├── schema.graphql       # Centralized GraphQL schema
│   │   │   │   └── resolvers/           # GraphQL resolvers for handling queries and mutations
│   │   │   ├── gateway/                 # API gateway (authentication, rate limiting, etc.)
│   │   │   │   ├── routes/             # API routes for frontend apps
│   │   │   │   ├── middlewares/        # Middleware for API gateway
│   │   │   │   ├── rate-limiting/      # Rate limiting for API requests
│   │   │   │   └── load-balancing/    # Load balancing for API requests
│   │   │   ├── routes/                 # API routes for frontend apps
│   │   │   │   ├── auth/              # Authentication routes
│   │   │   │   ├── users/            # User management routes
│   │   │   │   ├── admin_dashboard/ # Admin dashboard routes
│   │   │   │   ├── afro_art_collective/ # Afro Art Collective routes
│   │   │   │   ├── big_biz_district/ # Big Biz District routes
│   │   │   │   ├── homebase/        # Homebase routes
│   │   │   │   ├── mouseion/       # Mouseion routes
│   │   │   │   ├── phantomrail/   # Phantomrail routes
│   │   │   │   ├── rooting_reality/ # Rooting Reality routes
│   │   │   │   └── the_playground/ # The Playground routes
│   │   │   ├── controllers/          # API controllers for frontend apps
│   │   │   │   ├── auth/           # Authentication controllers
│   │   │   │   ├── users/       # User management controllers
│   │   │   │   ├── admin_dashboard/ # Admin dashboard controllers
│   │   │   │   ├── afro_art_collective/ # Afro Art Collective controllers
│   │   │   │   ├── big_biz_district/ # Big Biz District controllers
│   │   │   │   ├── homebase/      # Homebase controllers
│   │   │   │   ├── mouseion/    # Mouseion controllers
│   │   │   │   ├── phantomrail/ # Phantomrail controllers
│   │   │   │   ├── rooting_reality/ # Rooting Reality controllers
│   │   │   │   └── the_playground/ # The Playground controllers
│   │   │   ├── middlewares/         # Middleware for API routes
│   │   │   │   ├── auth/          # Authentication middleware
│   │   │   │   ├── validation/   # Request validation middleware
│   │   │   │   ├── error/      # Error handling middleware
│   │   │   │   └── logging/  # Logging middleware
│   │   │   ├── validators/        # Request validation schemas
│   │   │   └── swagger/          # Swagger API documentation
│   │   ├── services/                    # Backend services (besides centralized ones)
│   │   │   ├── auth/                    # Authentication service
│   │   │   ├── email/                   # Email service
│   │   │   ├── notification/            # Notification service
│   │   │   ├── payment/                # Payment service
│   │   │   ├── storage/                 # File storage (e.g., AWS S3, Google Cloud)
│   │   │   ├── admin_dashboard/        # Admin dashboard service
│   │   │   ├── afro_art_collective/   # Afro Art Collective service
│   │   │   ├── big_biz_district/     # Big Biz District service
│   │   │   ├── homebase/           # Homebase service
│   │   │   ├── mouseion/         # Mouseion service
│   │   │   ├── phantomrail/     # Phantomrail service
│   │   │   ├── rooting_reality/ # Rooting Reality service
│   │   │   └── the_playground/ # The Playground service
│   │   ├── blockchain/                  # Blockchain-related services
│   │   │   ├── stellar/                    # Stellar blockchain interaction
│   │   │   │   ├── services/              # Stellar blockchain services
│   │   │   │   ├── contracts/           # Stellar smart contracts
│   │   │   │   └── utils/               # Stellar utility functions
│   │   │   ├── casper/                  # Casper blockchain interaction
│   │   │   │   ├── services/           # Casper blockchain services
│   │   │   │   ├── contracts/       # Casper smart contracts
│   │   │   │   └── utils/          # Casper utility functions
│   │   │   ├── ethereum/                # Ethereum blockchain interaction
│   │   │   │   ├── services/          # Ethereum blockchain services
│   │   │   │   ├── contracts/      # Ethereum smart contracts
│   │   │   │   └── utils/        # Ethereum utility functions
│   │   │   └── contracts/               # Smart contract deployment using Hardhat
│   │   ├── config/                      # Configurations for backend
│   │   │   ├── database/               # Database configurations
│   │   │   │   ├── postgres/            # Postgres configurations for databases
│   │   │   │   │   ├── admin_dashboard/ # Admin dashboard database
│   │   │   │   │   ├── afro_art_collective/ # Afro Art Collective database
│   │   │   │   │   ├── big_biz_district/   # Big Biz District database
│   │   │   │   │   ├── businesses/        # Businesses database
│   │   │   │   │   ├── homebase/        # Homebase database
│   │   │   │   │   ├── mouseion/      # Mouseion database
│   │   │   │   │   ├── phantomrail/  # Phantomrail database
│   │   │   │   │   ├── rooting_reality/ # Rooting Reality database
│   │   │   │   │   ├── the_playground/ # The Playground database
│   │   │   │   │   └── users/        # Users database
│   │   │   │   └── mongodb/             # MongoDB configurations
│   │   │   ├── redis/                   # Redis caching and sessions
│   │   │   │   ├── cache/              # Redis cache
│   │   │   │   └── sessions/         # Redis sessions
│   │   │   └── rabbitmq/                # RabbitMQ message queues
│   │   │       ├── queues/            # RabbitMQ queues
│   │   │       └── exchanges/       # RabbitMQ exchanges
│   │   ├── models/                      # Data models (PostgreSQL, MongoDB)
│   │   │   ├── postgres/               # PostgreSQL models
│   │   │   └── mongodb/               # MongoDB models
│   │   ├── middlewares/                 # Middleware (auth, error handling, etc.)
│   │   ├── tests/                       # Unit, integration, and e2e tests
│   │       ├── unit/                  # Unit tests
│   │       ├── integration/         # Integration tests
│   │       └── e2e/                # End-to-end tests
│   │   └── utils/                       # Utility functions (encryption, validation)
│   │   │   ├── encryption/             # Encryption functions
│   │   │   ├── validation/           # Validation functions
│   │   │   └── formatting/         # Formatting functions
│   │   ├── security/                       # Security-specific configurations and setups
│   │   │   ├── helmet.js                   # Security middleware for HTTP headers
│   │   │   ├── fail2ban/                   # Fail2ban configuration for intrusion prevention
│   │   │   ├── zap-scan.js                 # OWASP ZAP integration for security scanning
│   │   │   └── trufflehog.js               # TruffleHog configuration for secret scanning
│   ├── migrations/                      # Database migrations
│   │   ├── admin_dashboard/           # Admin dashboard migrations
│   │   ├── afro_art_collective/     # Afro Art Collective migrations
│   │   ├── big_biz_district/        # Big Biz District migrations
│   │   ├── businesses/              # Businesses migrations
│   │   ├── homebase/              # Homebase migrations
│   │   ├── mouseion/            # Mouseion migrations
│   │   ├── phantomrail/        # Phantomrail migrations
│   │   ├── rooting_reality/   # Rooting Reality migrations
│   │   ├── the_playground/    # The Playground migrations
│   │   └── users/             # Users migrations
│   ├── docs/                            # Backend API documentation
│   ├── .env.example                     # Example environment variables
│   ├── Dockerfile                       # Dockerfile for backend
│   ├── package.json                    # Backend package.json
│   └── README.md                        # Backend README file
├── frontend/                            # Frontend React Native apps
│   ├── apps/                            # Each app has its own folder
│   │   ├── homebase/                   # Homebase app for AfroRoot
│   │   │   ├── src/                   # Source code for Homebase app
│   │   │   │   ├── assets/            # Images, icons, and fonts
│   │   │   │   │   ├── images/       # Images for Homebase app
│   │   │   │   │   ├── icons/       # Icons for Homebase app
│   │   │   │   │   └── fonts/     # Fonts for Homebase app
│   │   │   │   ├── components/       # UI components for Homebase app
│   │   │   │   │   ├── common/     # Common components
│   │   │   │   │   ├── forms/     # Form components
│   │   │   │   │   └── features/ # Feature-specific components
│   │   │   │   ├── navigation/      # Navigation structure for Homebase app
│   │   │   │   │   ├── stacks/    # Stack navigators
│   │   │   │   │   └── tabs/    # Tab navigators
│   │   │   │   ├── screens/       # Screens for Homebase app
│   │   │   │   │   ├── auth/    # Authentication screens
│   │   │   │   │   ├── profile/  # Profile screens
│   │   │   │   │   └── features/ # Feature-specific screens
│   │   │   │   ├── services/      # Services for Homebase app
│   │   │   │   │   ├── api/     # API services for Homebase app
│   │   │   │   │   ├── blockchain/ # Blockchain services for Homebase app
│   │   │   │   │   └── storage/    # Storage services for Homebase app
│   │   │   │   ├── store/        # Redux store for Homebase app
│   │   │   │   │   ├── slices/  # Redux slices
│   │   │   │   │   ├── actions/  # Redux actions
│   │   │   │   │   └── selectors/  # Redux selectors
│   │   │   │   ├── utils/      # Utility functions for Homebase app
│   │   │   │   │   ├── formatting/ # Formatting functions
│   │   │   │   │   ├── validation/ # Validation functions
│   │   │   │   │   └── helpers/  # Helper functions
│   │   │   │   ├── hooks/     # Custom hooks for Homebase app
│   │   │   │   │   ├── api/  # API hooks
│   │   │   │   │   ├── auth/ # Auth hooks
│   │   │   │   │   └── common/ # Common hooks
│   │   │   │   └── App.tsx   # Entry point for Homebase app
│   │   │   ├── __tests__/    # Tests for Homebase app
│   │   │   │   ├── components/ # Component tests
│   │   │   │   ├── screens/  # Screen tests
│   │   │   │   └── services/ # Service tests
│   │   │   ├── .env  # Environment variables for Homebase app
│   │   │   ├── package.json  # Homebase package.json
│   │   │   └── README.md # Homebase README
│   │   ├── big_biz_district/
│   │   │   ├── src/
│   │   │   │   ├── assets/
│   │   │   │   │   ├── images/
│   │   │   │   │   ├── icons/
│   │   │   │   │   └── fonts/
│   │   │   │   ├── components/
│   │   │   │   │   ├── common/
│   │   │   │   │   ├── forms/
│   │   │   │   │   └── features/
│   │   │   │   ├── navigation/
│   │   │   │   │   ├── stacks/
│   │   │   │   │   └── tabs/
│   │   │   │   ├── screens/
│   │   │   │   │   ├── auth/
│   │   │   │   │   ├── profile/
│   │   │   │   │   └── features/
│   │   │   │   ├── services/
│   │   │   │   │   ├── api/
│   │   │   │   │   ├── blockchain/
│   │   │   │   │   └── storage/
│   │   │   │   ├── store/
│   │   │   │   │   ├── slices/
│   │   │   │   │   ├── actions/
│   │   │   │   │   └── selectors/
│   │   │   │   ├── utils/
│   │   │   │   │   ├── formatting/
│   │   │   │   │   ├── validation/
│   │   │   │   │   └── helpers/
│   │   │   │   ├── hooks/
│   │   │   │   │   ├── api/
│   │   │   │   │   ├── auth/
│   │   │   │   │   └── common/
│   │   │   │   └── App.tsx
│   │   │   ├── __tests__/
│   │   │   │   ├── components/
│   │   │   │   ├── screens/
│   │   │   │   └── services/
│   │   │   ├── .env
│   │   │   ├── package.json
│   │   │   └── README.md
│   │   ├── phantomrail/
│   │   │   ├── src/
│   │   │   │   ├── assets/
│   │   │   │   │   ├── images/
│   │   │   │   │   ├── icons/
│   │   │   │   │   └── fonts/
│   │   │   │   ├── components/
│   │   │   │   │   ├── common/
│   │   │   │   │   ├── forms/
│   │   │   │   │   └── features/
│   │   │   │   ├── navigation/
│   │   │   │   │   ├── stacks/
│   │   │   │   │   └── tabs/
│   │   │   │   ├── screens/
│   │   │   │   │   ├── auth/
│   │   │   │   │   ├── profile/
│   │   │   │   │   └── features/
│   │   │   │   ├── services/
│   │   │   │   │   ├── api/
│   │   │   │   │   ├── blockchain/
│   │   │   │   │   └── storage/
│   │   │   │   ├── store/
│   │   │   │   │   ├── slices/
│   │   │   │   │   ├── actions/
│   │   │   │   │   └── selectors/
│   │   │   │   ├── utils/
│   │   │   │   │   ├── formatting/
│   │   │   │   │   ├── validation/
│   │   │   │   │   └── helpers/
│   │   │   │   ├── hooks/
│   │   │   │   │   ├── api/
│   │   │   │   │   ├── auth/
│   │   │   │   │   └── common/
│   │   │   │   └── App.tsx
│   │   │   ├── __tests__/
│   │   │   │   ├── components/
│   │   │   │   ├── screens/
│   │   │   │   └── services/
│   │   │   ├── .env
│   │   │   ├── package.json
│   │   │   └── README.md
│   │   ├── mouseion/
│   │   │   ├── src/
│   │   │   │   ├── assets/
│   │   │   │   │   ├── images/
│   │   │   │   │   ├── icons/
│   │   │   │   │   └── fonts/
│   │   │   │   ├── components/
│   │   │   │   │   ├── common/
│   │   │   │   │   ├── forms/
│   │   │   │   │   └── features/
│   │   │   │   ├── navigation/
│   │   │   │   │   ├── stacks/
│   │   │   │   │   └── tabs/
│   │   │   │   ├── screens/
│   │   │   │   │   ├── auth/
│   │   │   │   │   ├── profile/
│   │   │   │   │   └── features/
│   │   │   │   ├── services/
│   │   │   │   │   ├── api/
│   │   │   │   │   ├── blockchain/
│   │   │   │   │   └── storage/
│   │   │   │   ├── store/
│   │   │   │   │   ├── slices/
│   │   │   │   │   ├── actions/
│   │   │   │   │   └── selectors/
│   │   │   │   ├── utils/
│   │   │   │   │   ├── formatting/
│   │   │   │   │   ├── validation/
│   │   │   │   │   └── helpers/
│   │   │   │   ├── hooks/
│   │   │   │   │   ├── api/
│   │   │   │   │   ├── auth/
│   │   │   │   │   └── common/
│   │   │   │   └── App.tsx
│   │   │   ├── __tests__/
│   │   │   │   ├── components/
│   │   │   │   ├── screens/
│   │   │   │   └── services/
│   │   │   ├── .env
│   │   │   ├── package.json
│   │   │   └── README.md
│   │   ├── rooting_reality/
│   │   │   ├── src/
│   │   │   │   ├── assets/
│   │   │   │   │   ├── images/
│   │   │   │   │   ├── icons/
│   │   │   │   │   └── fonts/
│   │   │   │   ├── components/
│   │   │   │   │   ├── common/
│   │   │   │   │   ├── forms/
│   │   │   │   │   └── features/
│   │   │   │   ├── navigation/
│   │   │   │   │   ├── stacks/
│   │   │   │   │   └── tabs/
│   │   │   │   ├── screens/
│   │   │   │   │   ├── auth/
│   │   │   │   │   ├── profile/
│   │   │   │   │   └── features/
│   │   │   │   ├── services/
│   │   │   │   │   ├── api/
│   │   │   │   │   ├── blockchain/
│   │   │   │   │   └── storage/
│   │   │   │   ├── store/
│   │   │   │   │   ├── slices/
│   │   │   │   │   ├── actions/
│   │   │   │   │   └── selectors/
│   │   │   │   ├── utils/
│   │   │   │   │   ├── formatting/
│   │   │   │   │   ├── validation/
│   │   │   │   │   └── helpers/
│   │   │   │   ├── hooks/
│   │   │   │   │   ├── api/
│   │   │   │   │   ├── auth/
│   │   │   │   │   └── common/
│   │   │   │   └── App.tsx
│   │   │   ├── __tests__/
│   │   │   │   ├── components/
│   │   │   │   ├── screens/
│   │   │   │   └── services/
│   │   │   ├── .env
│   │   │   ├── package.json
│   │   │   └── README.md
│   │   ├── the_playground/
│   │   │   ├── src/
│   │   │   │   ├── assets/
│   │   │   │   │   ├── images/
│   │   │   │   │   ├── icons/
│   │   │   │   │   └── fonts/
│   │   │   │   ├── components/
│   │   │   │   │   ├── common/
│   │   │   │   │   ├── forms/
│   │   │   │   │   └── features/
│   │   │   │   ├── navigation/
│   │   │   │   │   ├── stacks/
│   │   │   │   │   └── tabs/
│   │   │   │   ├── screens/
│   │   │   │   │   ├── auth/
│   │   │   │   │   ├── profile/
│   │   │   │   │   └── features/
│   │   │   │   ├── services/
│   │   │   │   │   ├── api/
│   │   │   │   │   ├── blockchain/
│   │   │   │   │   └── storage/
│   │   │   │   ├── store/
│   │   │   │   │   ├── slices/
│   │   │   │   │   ├── actions/
│   │   │   │   │   └── selectors/
│   │   │   │   ├── utils/
│   │   │   │   │   ├── formatting/
│   │   │   │   │   ├── validation/
│   │   │   │   │   └── helpers/
│   │   │   │   ├── hooks/
│   │   │   │   │   ├── api/
│   │   │   │   │   ├── auth/
│   │   │   │   │   └── common/
│   │   │   │   └── App.tsx
│   │   │   ├── __tests__/
│   │   │   │   ├── components/
│   │   │   │   ├── screens/
│   │   │   │   └── services/
│   │   │   ├── .env
│   │   │   ├── package.json
│   │   │   └── README.md
│   │   ├── afro_art_collective/
│   │   │   ├── src/
│   │   │   │   ├── assets/
│   │   │   │   │   ├── images/
│   │   │   │   │   ├── icons/
│   │   │   │   │   └── fonts/
│   │   │   │   ├── components/
│   │   │   │   │   ├── common/
│   │   │   │   │   ├── forms/
│   │   │   │   │   └── features/
│   │   │   │   ├── navigation/
│   │   │   │   │   ├── stacks/
│   │   │   │   │   └── tabs/
│   │   │   │   ├── screens/
│   │   │   │   │   ├── auth/
│   │   │   │   │   ├── profile/
│   │   │   │   │   └── features/
│   │   │   │   ├── services/
│   │   │   │   │   ├── api/
│   │   │   │   │   ├── blockchain/
│   │   │   │   │   └── storage/
│   │   │   │   ├── store/
│   │   │   │   │   ├── slices/
│   │   │   │   │   ├── actions/
│   │   │   │   │   └── selectors/
│   │   │   │   ├── utils/
│   │   │   │   │   ├── formatting/
│   │   │   │   │   ├── validation/
│   │   │   │   │   └── helpers/
│   │   │   │   ├── hooks/
│   │   │   │   │   ├── api/
│   │   │   │   │   ├── auth/
│   │   │   │   │   └── common/
│   │   │   │   └── App.tsx
│   │   │   ├── __tests__/
│   │   │   │   ├── components/
│   │   │   │   ├── screens/
│   │   │   │   └── services/
│   │   │   ├── .env
│   │   │   ├── package.json
│   │   │   └── README.md
│   ├── shared/                          # Shared components, hooks, services across apps
│   │   ├── components/                  # Shared UI components (e.g., layouts, forms)
│   │   ├── services/                    # Shared API, blockchain, storage services
│   │   ├── hooks/                       # Shared custom hooks
│   │   ├── utils/                       # Shared utility functions
│   └── README.md                        # Frontend README
├── admin-dashboard/                     # Admin dashboard for managing AfroRoot apps
│   ├── src/
│   │   ├── assets/                      # Images, icons, and fonts
│   │   ├── components/                  # UI components for admin dashboard
│   │   │   ├── common/                 # Common components
│   │   │   ├── tables/                # Table components
│   │   │   └── charts/              # Chart components
│   │   ├── layouts/                     # Admin layout structures
│   │   │   ├── main/                  # Main layout for admin dashboard
│   │   │   └── auth/                 # Auth layout for login, register
│   │   ├── pages/                       # Pages for managing apps, users, analytics
│   │   │   ├── auth/                  # Auth pages (login, register)
│   │   │   ├── dashboard/          # Dashboard pages
│   │   │   ├── afro_art_collective/  # Afro Art Collective pages
│   │   │   ├── big_biz_district/    # Big Biz District pages
│   │   │   ├── homebase/           # Homebase pages
│   │   │   ├── mouseion/         # Mouseion pages
│   │   │   ├── phantomrail/   # Phantomrail pages
│   │   │   ├── rooting_reality/  # Rooting Reality pages
│   │   │   └── the_playground/   # The Playground pages
│   │   ├── services/                    # Analytics, reporting, and API services
│   │   │   ├── api/                  # API services for admin dashboard
│   │   │   ├── analytics/         # Analytics services
│   │   │   └── reporting/          # Reporting services
│   │   ├── store/                       # Redux store for the dashboard
│   │   └── App.tsx                      # Entry point for admin dashboard
│   ├── .env.example                     # Example environment variables
│   ├── Dockerfile                       # Dockerfile for admin dashboard
│   ├── package.json                  # Admin dashboard package.json
│   └── README.md                        # Admin dashboard README
├── infrastructure/                      # Infrastructure as code (Terraform, Kubernetes)
│   ├── terraform/                       # Terraform configurations
│   │   ├── environments/                # Dev, staging, and production environments
│   │   ├── modules/                     # Reusable Terraform modules
│   │   └── variables/                   # Environment variables for Terraform
│   ├── kubernetes/                      # Kubernetes deployment files
│   │   ├── deployments/                 # Deployment configuration
│   │   ├── services/                    # Kubernetes service configuration
│   │   └── configs/                     # Kubernetes config files
│   ├── monitoring/                      # Monitoring and logging tools (Prometheus, Grafana)
│   ├── wazuh/
│   │   ├──wazuh.yml        # Wazuh configuration for security event monitoring
│   │   ├── prometheus/                  # Prometheus monitoring configuration
│   │   ├── grafana/                     # Grafana dashboards
│   │   └── elk/                         # ELK stack for logs
├── docs/                                # Documentation for the project
│   ├── architecture/                    # Architecture diagrams and decisions
│   ├── api/                             # API documentation
│   ├── deployment/                      # Deployment guides
│   └── development/                     # Developer guides
├── scripts/                             # Utility scripts for setup, build, and deployment
│   ├── setup/                           # Setup scripts for local development
│   ├── build/                           # Build scripts for CI/CD
│   └── deploy/                          # Deployment scripts for Kubernetes
├── .dockerignore                        # Docker ignore file
├── .gitignore                           # Git ignore file
├── .eslintrc.js                         # ESLint configuration for linting
├── .prettierrc                          # Prettier configuration for formatting
├── docker-compose.yml                   # Docker Compose for local development
├── lerna.json                           # Lerna monorepo configuration
├── package.json                         # Root package.json for dependencies
└── README.md                            # Root README file
