ARG PERFORCE_PASSWORD
FROM ubuntu:focal

# Update our main system

RUN apt-get update
RUN apt-get dist-upgrade -y

# Get some dependencies for adding apt repositories

RUN apt-get install -y wget gnupg

# Add perforce repo

RUN wget -qO - https://package.perforce.com/perforce.pubkey | apt-key add -
RUN echo 'deb http://package.perforce.com/apt/ubuntu focal release' > /etc/apt/sources.list.d/perforce.list
RUN apt-get update


# Actually install it

RUN apt-get install -y helix-p4d

COPY ./entrypoint.sh .
RUN chmod u+x ./entrypoint.sh

COPY main.conf /etc/perforce/p4dctl.conf.d/main.conf
RUN chown -R perforce:perforce /etc/perforce/p4dctl.conf.d

RUN /opt/perforce/sbin/configure-helix-p4d.sh main -n -u perforce -P ${PERFORCE_PASSWORD} --unicode --case 1
# Go into our directory, start Perforce, and view the log outputs
ENTRYPOINT [ "./entrypoint.sh" ]


# P4ROOT = ROOT DRIVE
# P4JOURNAL = DB Journal
# by default metadata of files is stored at p4root
# P4PORT=ssl:1666 or P4PORT=ssl:192.168.1.2:1666 or P4PORT=ssl:myhost.name.com:1666
# p4 configure set security=3 enforces ticket based auth 