FROM public.ecr.aws/lambda/python:3.8
LABEL maintainer="raphaeldias.ti@gmail.com"

COPY . ${LAMBDA_TASK_ROOT}
RUN  pip3 install -r requirements.txt --target "${LAMBDA_TASK_ROOT}"

CMD [ "index.lambda_handler" ]