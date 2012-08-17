#!/bin/sh

# This "tests" the code by running the examples and checking program
# return codes.
# 
errors=0
for example in ./examples/*.rb; do
    java -jar ocelot.jar $example
    if [ $? -ne 0 ]; then
      let "errors += 1"
    fi
done

if [ $errors -gt 0 ]; then
  echo "! $errors tests FAILED :("
else
  echo "+ All tests PASSED :)"
fi
