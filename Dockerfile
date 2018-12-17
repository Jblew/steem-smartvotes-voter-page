#§ 'FROM node:' + data.config.npm.node.version + '-alpine'
FROM node:10.12-alpine


ADD . /src/
WORKDIR /src/

RUN npm install
RUN NODE_ENV=production npm run build | tr -d '{}[]'

# CMD npm run serve

FROM nginx:alpine
COPY --from=0 /src/index.html /usr/share/nginx/html/index.html
COPY --from=0 /src/dist /usr/share/nginx/html/dist
RUN ls -a /usr/share/nginx/html

##§ '\n' + data.config.docker.generateDockerfileFrontMatter(data) + '\n' §##
LABEL maintainer="The Wise Team (https://wise-team.io/) <jedrzejblew@gmail.com>"
LABEL vote.wise.wise-version="3.0.3"
LABEL vote.wise.license="MIT"
LABEL vote.wise.repository="steem-wise-voter-page"
##§ §.##