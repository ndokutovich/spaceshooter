# Contributing to Space Shooter

First off, thank you for considering contributing to Space Shooter! It's people like you that make Space Shooter such a great game.

## Code of Conduct

This project and everyone participating in it is governed by our [Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code.

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check the issue list as you might find out that you don't need to create one. When you are creating a bug report, please include as many details as possible:

* Use a clear and descriptive title
* Describe the exact steps to reproduce the problem
* Provide specific examples to demonstrate the steps
* Describe the behavior you observed after following the steps
* Explain which behavior you expected to see instead and why
* Include screenshots if possible
* Include your environment details (OS, Flutter version, etc.)

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion, please include:

* A clear and descriptive title
* A detailed description of the proposed feature
* Explain why this enhancement would be useful
* List any similar features in other games if you know of any
* Include mockups or sketches if applicable

### Pull Requests

* Fork the repo and create your branch from `main`
* If you've added code that should be tested, add tests
* Ensure the test suite passes
* Make sure your code follows the existing code style
* Write a convincing description of your PR and why we should land it

## Development Process

1. Fork the repository
2. Create a new branch for your feature/fix
3. Write your code
4. Add or update tests if needed
5. Run the test suite
6. Push your branch and submit a pull request
7. Wait for review and address any comments

### Commit Messages

We follow the [Conventional Commits](https://www.conventionalcommits.org/) specification. Each commit message should be structured as follows:

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

Types include:
* feat: A new feature
* fix: A bug fix
* docs: Documentation only changes
* style: Changes that do not affect the meaning of the code
* refactor: A code change that neither fixes a bug nor adds a feature
* perf: A code change that improves performance
* test: Adding missing tests or correcting existing tests
* chore: Changes to the build process or auxiliary tools

### Code Style

* Follow the [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines
* Use meaningful variable and function names
* Keep functions small and focused
* Comment complex logic
* Use consistent formatting (run `dart format` before committing)

## Project Structure

Please maintain the existing project structure:

```
lib/
├── game/           # Game-specific code
├── models/         # Data models
├── screens/        # UI screens
├── utils/          # Utilities
└── widgets/        # Reusable widgets
```

## Testing

* Write unit tests for new functionality
* Update existing tests when changing behavior
* Run `flutter test` before submitting PR
* Aim for high test coverage

## Documentation

* Update README.md if needed
* Document new features
* Update API documentation
* Include comments for complex logic

## Questions?

Feel free to ask for help! You can:
* Open an issue
* Join our Discord server
* Contact the maintainers

## License

By contributing, you agree that your contributions will be licensed under the MIT License. 