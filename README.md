# throneless-toolbox
Custom toolbox image for Throneless developers

## To Update
1. Remove your old toolbox. For example, if your toolbox was called `dev`, delete it with `toolbox rm dev`. If the toolbox is already running, you may need to run `podman stop dev`
2. Remove the old throneless-toolbox image. To see available images, run `toolbox list` and then remove the image with `toolbox rmi <Image ID>`
3. Create the new toolbox. For example, to create a new toolbox called `dev`, run `toolbox create --image ghcr.io/throneless-tech/throneless-toolbox dev`

## Mise
This toolbox image includes `mise` for installing development tools. For information on how to use `mise`, see https://mise.jdx.dev/
