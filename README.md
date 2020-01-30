# aws-code-deploy Orb [![CircleCI Build Status](https://circleci.com/gh/CircleCI-Public/aws-code-deploy-orb.svg?style=shield "CircleCI Build Status")](https://circleci.com/gh/CircleCI-Public/aws-code-deploy-orb) [![CircleCI Orb Version](https://img.shields.io/badge/endpoint.svg?url=https://badges.circleci.io/orb/circleci/aws-code-deploy)](https://circleci.com/orbs/registry/orb/circleci/aws-code-deploy) [![GitHub License](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://raw.githubusercontent.com/CircleCI-Public/aws-code-deploy-orb/master/LICENSE) [![CircleCI Community](https://img.shields.io/badge/community-CircleCI%20Discuss-343434.svg)](https://discuss.circleci.com/c/ecosystem/orbs)

Easily deploy applications to AWS CodeDeploy on CircleCI with the aws-code-deploy orb

## Usage

Example use-cases are provided on the orb [registry page](https://circleci.com/orbs/registry/orb/circleci/aws-code-deploy#usage-examples). Source for these examples can be found within the `src/examples` directory.


## Resources

[CircleCI Orb Registry Page](https://circleci.com/orbs/registry/orb/circleci/aws-code-deploy) - The official registry page of this orb for all versions, executors, commands, and jobs described.  
[CircleCI Orb Docs](https://circleci.com/docs/2.0/orb-intro/#section=configuration) - Docs for using and creating CircleCI Orbs.
[AWS CodeDeploy](https://aws.amazon.com/codedeploy/) - Automate code deployments to maintain application uptime.
[AWS CodeDeploy Docs](https://docs.aws.amazon.com/codedeploy/latest/userguide/welcome.html) - User Guide

### How To Contribute

We welcome [issues](https://github.com/CircleCI-Public/aws-code-deploy-orb/issues) to and [pull requests](https://github.com/CircleCI-Public/aws-code-deploy-orb/pulls) against this repository!

To publish a new production version:
* Create a PR to the `Alpha` branch with your changes. This will act as a "staging" branch.
* When ready to publish a new production version, create a PR from `Alpha` to `master`. The Git Subject should include `[semver:patch|minor|release|skip]` to indicate the type of release.
* On merge, the release will be published to the orb registry automatically.

For further questions/comments about this or other orbs, visit the Orb Category of [CircleCI Discuss](https://discuss.circleci.com/c/orbs).
