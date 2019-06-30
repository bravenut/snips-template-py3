#/usr/bin/env bash -e

# copy config.ini.default if config.ini doesn't exist
if [ ! -e "./config.ini" ]
then
    cp config.ini.default config.ini
fi

PYTHON=`which python3`
VENV=venv

if [ -f "$PYTHON" ]
then
	if [ ! -d "$VENV" ]
	then
		$PYTHON -m venv $VENV
	else
		if [ -e $VENV/bin/python2 ]
		then
			# if python2 env exists, delete it first
			# before creating a new python3 venv
			rm -r $VENV
			$PYTHON -m venv $VENV
		fi
	fi

	# activate venv and install requirements
	. $VENV/bin/activate
	pip3 install -r requirements.txt
else
	>&2 echo "Could not find Python 3. Please install it."
fi
