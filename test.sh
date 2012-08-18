#!/bin/sh

# This "tests" the code by running the examples and checking program
# return codes.
# 
errors=0
for example in ./examples/*.rb; do
  echo "testing $(basename $example) ... "
  java -jar ocelot.jar $example > /dev/null
  if [ $? -ne 0 ]; then
    let "errors += 1"
  fi
done

if [ $errors -gt 0 ]; then
  echo "! $errors tests FAILED :("
else
  echo "+ All tests PASSED :)"
  rm -fv *.ods *.odt *.odp
fi
