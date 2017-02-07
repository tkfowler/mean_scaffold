#!/bin/bash

echo "  "
echo " Welcome to mean_scaffold "
echo "  "
echo " READY "
echo "  "
echo "  "
echo "            ___        ___    __ __ __ __          _          ___       __                  "
echo "           |   \      /   |  |  __ __ ___|        / \        |   \     |  |                 "
echo "           | |\ \    / /| |  | |                 / | \       |    \    |  |                 "
echo "           | | \ \  / / | |  | |__ __ __        /  |  \      |     \   |  |                 "
echo "           | |  \ \/ /  | |  |  __ __ __|      /  ___  \     |  |\  \  |  |                 "
echo "           | |   \__/   | |  | |              /  /   \  \    |  | \  \_|  |                 "
echo "           | |          | |  | |__ __ ___    /  /     \  \   |  |  \      |                 "
echo "           |_|          |_|  |__ __ __ __|  /__/       \__\  |__|   \_____|                 "
echo "  																	                      "
echo "                                                                                            " 
echo "  __ __ __     __ __ __                   __ ___     __ ___     __ __     _        ___      "
echo " |  _____  |  |  _____  |       /\       |  ____|   |  ____|   |     |   | |      |    \    "
echo " | |     |_|  | |     |_|      /  \      | |        | |        |  |  |   | |      |  |  |   "
echo " | |_______   | |             /    \     | |___     | |___     |  |  |   | |      |  |  |   "
echo " |_______  |  | |      _     /  /\  \    |  ___|    |  ___|    |  |  |   | |      |  |  |   "
echo "  _______| |  | |_____| |   /  /  \  \   | |        | |        |  |  |   | |___   |  |  |   "
echo " |__ __ __ |  |__ __ __ |  /__/    \__\  |_|        |_|        |__ __|   |__ __|  |__ _/    "
echo "  														                                  "
echo "  "		
echo "Enter your Project Name and press [ENTER]: "
read project_name
mkdir $project_name
cd $project_name
mkdir ./client
mkdir ./client/assets
mkdir ./client/assets/partials
mkdir ./client/assets/js
touch ./client/index.html
touch ./client/app.js
touch ./client/assets/js/indexController.js
touch ./client/assets/partials/index.html
mkdir ./server
mkdir ./server/config
mkdir ./server/models
mkdir ./server/controllers
touch ./server.js
touch ./server/config/routes.js
touch ./server/config/mongoose.js

#  /====================================================================/  #
#  /====================================================================/  #
#                                  SERVER SIDE                             #
#  /====================================================================/  #
#  /====================================================================/  #

#  /====================================================================/  #
#                                     config                               #
#  /====================================================================/  #


#  /====================================================================/  #
#                                  mongoose.js                             #
#  /====================================================================/  #

echo " var mongoose = require('mongoose'), " >> ./server/config/mongoose.js
echo " 	       fs = require('fs'), " >> ./server/config/mongoose.js
echo " 	     path = require('path'); " >> ./server/config/mongoose.js
echo ' mongoose.connect("mongodb://localhost/'$project_name'"); ' >> ./server/config/mongoose.js
echo " var models_path = path.join(__dirname, './../models'); " >> ./server/config/mongoose.js
echo " fs.readdirSync( models_path ).forEach( function(file) { " >> ./server/config/mongoose.js
echo "   if( file.indexOf('.js') >= 0 ) { " >> ./server/config/mongoose.js
echo "	   require( models_path + '/' + file ); " >> ./server/config/mongoose.js
echo "   } " >> ./server/config/mongoose.js
echo " }) " >> ./server/config/mongoose.js


#  /====================================================================/  #
#                                  server.js                               #
#  /====================================================================/  #
breakdollars='$'
echo " var express = require('express'), " >> ./server.js
echo "     bp      = require('body-parser'), " >> ./server.js
echo "     path    = require('path'), " >> ./server.js
echo "     port    = process.env.PORT || 8000, " >> ./server.js
echo "     app     = express(); " >> ./server.js
echo " app.use( express.static( path.join( __dirname, 'client' ))); " >> ./server.js
echo " app.use( express.static( path.join( __dirname, 'bower_components' ))); " >> ./server.js
echo " app.use( bp.json() ); " >> ./server.js
echo " require('./server/config/mongoose.js'); " >> ./server.js
echo " require('./server/config/routes.js')(app); " >> ./server.js
echo " app.listen( port, function(){}); " >> ./server.js

if [ -f ./package.json ]; then
	echo "Already installed"
else
	npm init -y
	npm install express mongoose body-parser --save
fi
if [ -f ./bower.json ]; then
	echo "Already installed"
else
	yes '' | bower init
	bower install angular angular-route --save
fi

#  /====================================================================/  #
#                                     MODELS                               #
#  /====================================================================/  #

declare -a models_array
function pushModel() {
	echo ""
	echo "Enter your Model Name and press [ENTER]: "
	read model_name
	while [ -z $model_name ]; do
		echo ""
		echo "Enter your Model Name and press [ENTER]: "
		read model_name
	done
	model_name="$(echo $model_name | tr '[:upper:]' '[:lower:]')"
	model_name="$(tr '[:lower:]' '[:upper:]' <<< ${model_name:0:1})${model_name:1}"
	models_array+=('model' $model_name)
}
pushModel

function repeatModel() {
	echo ""
	echo "Another Model? Type no to exit: "
	read another_model
	another_model="$(echo $another_model | tr '[:upper:]' '[:lower:]')"
	if [ $another_model == 'yes' ]; then
		pushModel
		pushAttributes
	elif [ $another_model == 'no' ]; then
		break
	else
		echo ""
		echo "Invalid input. Must be YES or NO"
		repeatModel
	fi
}

function repeatAttribute(){
	echo ""
	echo "Another Attribute? Type no to exit: "
	read another_attr
	another_attr="$(echo $another_attr | tr '[:upper:]' '[:lower:]')"
	if [ $another_attr == 'yes' ]; then
		pushAttributes
	elif [ $another_attr == 'no' ]; then
		repeatModel
	else
		echo ""
		echo "Invalid input. Must be YES or NO"
		repeatAttribute
	fi
}
function validate() {
	for i in "${!arr[@]}"; do
		if [ $attr_type == ${arr[$i]} ]; then
			bool=true
			break
		else
			bool=false
		fi
	done
}
function pushAttributes() {
	echo ""
	echo "Enter Attribute NAME and press [ENTER]: "
	read attr_name
	while [ -z $attr_name ]; do
		echo "Enter Attribute Name and press [ENTER]: "
		read attr_name
	done

	attr_name="$(echo $attr_name | tr '[:upper:]' '[:lower:]')"
	models_array+=('a_name' $attr_name)
	echo ""
	echo "Enter Attribute TYPE and press [ENTER]: "
	read attr_type
	attr_type="$(echo $attr_type | tr '[:upper:]' '[:lower:]')"
	if [ $attr_type == 'string' ]; then
		echo ""
		echo "Do you want this attribute to be a text field? (yes/no)"
		read str_type
		if [ $str_type == 'yes' ]; then
			attr_type='text'
		fi
	fi
	while [ -z $attr_type ]; do
		echo ""
		echo "Enter Attribute TYPE and press [ENTER]: "
		read attr_type
	done
	
	attr_type="$(echo $attr_type | tr '[:upper:]' '[:lower:]')"
	arr=('string' 'number' 'date' 'boolean' 'array' 'text' 'objectid' 'objectsarray')
	validate
	while [ $bool == false ]; do
		echo ""
		echo "Enter VALID Attribute TYPE and press [ENTER]: "
		read attr_type
		validate
	done
	attr_type="$(tr '[:lower:]' '[:upper:]' <<< ${attr_type:0:1})${attr_type:1}"

	models_array+=('a_type' $attr_type)
	repeatAttribute
}
pushAttributes
echo ""
echo ""
echo ""
echo " Your project is ready "
echo ""
echo ""
echo ""
function setModels() {
	set_models_array=("${models_array[@]}")
	for g in "${!set_models_array[@]}"; do
		if [ "${set_models_array[$g]}" = 'Text' ]; then
			set_models_array[$g]="String"
		fi
	done

	for f in "${!set_models_array[@]}"; do
		length=${#set_models_array[@]}
		if [ "${set_models_array[$f]}" == 'model' ]; then
			currmodel="${set_models_array[$f+1]}"
			lowercurrmodel="$(echo $currmodel | tr '[:upper:]' '[:lower:]')"
			touch ./server/models/"$lowercurrmodel".js
			echo "var mongoose = require('mongoose');" >> ./server/models/"$lowercurrmodel".js
			echo "mongoose.Promise = global.Promise;" >> ./server/models/"$lowercurrmodel".js
			echo "var Schema   = mongoose.Schema," >> ./server/models/"$lowercurrmodel".js
			echo "    "$lowercurrmodel"Schema = new Schema({" >> ./server/models/"$lowercurrmodel".js
			continue
		fi
		if [ "${set_models_array[$f]}" == 'a_name' ]; then
			# ref_model="$(tr '[:lower:]' '[:upper:]' <<< ${set_models_array[$f+1]:0:1})${set_models_array[$f+1]:1}" >> ./server/models/"$lowercurrmodel".js
			if [ "${set_models_array[$f+3]}" == 'Objectid' ]; then
				echo "    	_"${set_models_array[$f+1]}": {type: Schema.Types.ObjectId, ref:'"$currmodel"'}," >> ./server/models/"$lowercurrmodel".js
			elif [ "${set_models_array[$f+3]}" == 'Objectsarray' ]; then
				echo "    	"${set_models_array[$f+1]}": [{type: Schema.Types.ObjectId, ref:'"$currmodel"'}]," >> ./server/models/"$lowercurrmodel".js
			else
				echo "    	"${set_models_array[$f+1]}": {type: "${set_models_array[$f+3]}"}," >> ./server/models/"$lowercurrmodel".js
			fi
		fi
		if [ "${set_models_array[$f+1]}" == 'model' ] || [ "$f" == "$(( length-1 ))" ]; then
			echo " },{timestamps:true});" >> ./server/models/"$lowercurrmodel".js
			echo " 	  mongoose.model(""'"$currmodel"'"", "$lowercurrmodel"Schema)" >> ./server/models/"$lowercurrmodel".js
		fi
	done
}
setModels

#  /====================================================================/  #
#                                   CONTROLLERS                            #
#  /====================================================================/  #

function controllers() {
	objId=false
	objArr=false
	for f in "${!models_array[@]}"; do
		if [ "${models_array[$f]}" == 'Objectid' ]; then
			objId=true
			belongs="${models_array[$f-2]}"
			upper_belongs="$(tr '[:lower:]' '[:upper:]' <<< ${belongs:0:1})${belongs:1}"
		elif [ "${models_array[$f]}" == 'Objectsarray' ]; then
			objArr=true
			has="${models_array[$f-2]}"
			upper_has="$(tr '[:lower:]' '[:upper:]' <<< ${has:0:1})${has:1}"
		fi
	done
	for f in "${!models_array[@]}"; do
		length=${#models_array[@]}
		if [ "${models_array[$f]}" == 'model' ]; then
			currmodel="${models_array[$f+1]}"
			lowercurrmodel="$(echo $currmodel | tr '[:upper:]' '[:lower:]')"
			parens="()"
			echo ""
			echo "var mongoose = require('mongoose')," >> ./server/controllers/"$lowercurrmodel"s.js
			echo " " $currmodel "= mongoose.model(""'"$currmodel"'"");" >> ./server/controllers/"$lowercurrmodel"s.js
			echo " " >> ./server/controllers/"$lowercurrmodel"s.js
			echo "function "$lowercurrmodel"sController"$parens" {" >> ./server/controllers/"$lowercurrmodel"s.js
	# done
	# for f in "${!models_array[@]}"; do
			if [ "$objId" == true ]; then
				echo "  this.index = function(req,res) {" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "     "$currmodel".find({})" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "       .populate('"$has"').exec(function(err, "$lowercurrmodel"s) {" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "         if(err) { res.json(err); }" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "         else { res.json("$lowercurrmodel"s); }" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "     })" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "  }" >> ./server/controllers/"$lowercurrmodel"s.js
				echo " " >> ./server/controllers/"$lowercurrmodel"s.js
				echo ""
				echo "  this.create = function(req,res) {" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "     var "$lowercurrmodel" = new" $currmodel"(req.body);" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "     "$lowercurrmodel".save(function(err) {" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "       if(err) { res.json(err); }" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "       else { res.redirect('/"$lowercurrmodel"s'); }" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "     })" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "  }" >> ./server/controllers/"$lowercurrmodel"s.js
				echo " " >> ./server/controllers/"$lowercurrmodel"s.js
				echo ""
				echo "  this.show = function(req,res) {" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "     "$currmodel".findOne({_id:req.params.id})" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "       .populate('"$has"').exec(function(err, "$lowercurrmodel") {" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "         if(err) { res.json(err); }" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "         else { res.json("$lowercurrmodel"); }" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "     })" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "  }" >> ./server/controllers/"$lowercurrmodel"s.js
				echo " " >> ./server/controllers/"$lowercurrmodel"s.js
				echo ""
				echo "  this.update = function(req,res) {" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "     "$currmodel".update({_id:req.params.id}, req.body, function(err,"$lowercurrmodel") {" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "       if(err) { res.json(err); }" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "       else { res.json("$lowercurrmodel"); }" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "     })" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "  }" >> ./server/controllers/"$lowercurrmodel"s.js
				echo " " >> ./server/controllers/"$lowercurrmodel"s.js
				echo ""
				echo "this.destroy = function(req,res) {" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "     "$currmodel".remove({_id:req.params.id}, function(err,"$lowercurrmodel") {" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "       if(err) { res.json(err); }" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "       else { res.json("$lowercurrmodel"); }" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "     })" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "  }" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "}" >> ./server/controllers/"$lowercurrmodel"s.js
				echo ""
				echo "module.exports = new "$lowercurrmodel"sController"$parens"" >> ./server/controllers/"$lowercurrmodel"s.js
				objId=false
			elif [ "$objArr" == true ]; then
				echo "  this.index = function(req,res) {" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "     "$currmodel".find({}, function(err,"$lowercurrmodel"s) {" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "       if(err) { res.json(err); }" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "       else { res.json("$lowercurrmodel"s); }" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "     })" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "  }" >> ./server/controllers/"$lowercurrmodel"s.js
				echo " " >> ./server/controllers/"$lowercurrmodel"s.js
				echo ""
				echo "  this.create = function(req,res) {" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "     "$upper_belongs".findOne({_id:req.body."$belongs"._id}, function(err, "$belongs"){" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "        if(err) { res.json(err) }; " >> ./server/controllers/"$lowercurrmodel"s.js
				echo "        else { " >> ./server/controllers/"$lowercurrmodel"s.js
				echo "           var "$lowercurrmodel" = new" $currmodel"(req.body);" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "           "$lowercurrmodel".save(function(err) {" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "              if(err) { res.json(err); }" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "              else { " >> ./server/controllers/"$lowercurrmodel"s.js
				echo "                "$belongs"."$lowercurrmodel".push("$lowercurrmodel");" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "                "$belongs".save(function(err) {" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "                  if (err) { res.json(err); }" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "                  else { res.redirect('/"$lowercurrmodel"s')};" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "               })" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "             }" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "          })" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "        }" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "    })" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "  }" >> ./server/controllers/"$lowercurrmodel"s.js
				echo " " >> ./server/controllers/"$lowercurrmodel"s.js
				echo ""
				echo "  this.show = function(req,res) {" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "     "$currmodel".findOne({_id:req.params.id}, function(err,"$lowercurrmodel") {" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "       if(err) { res.json(err); }" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "       else { res.json("$lowercurrmodel"); }" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "     })" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "  }" >> ./server/controllers/"$lowercurrmodel"s.js
				echo " " >> ./server/controllers/"$lowercurrmodel"s.js
				echo ""
				echo "  this.update = function(req,res) {" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "     "$currmodel".update({_id:req.params.id}, req.body, function(err,"$lowercurrmodel") {" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "       if(err) { res.json(err); }" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "       else { res.json("$lowercurrmodel"); }" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "     })" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "  }" >> ./server/controllers/"$lowercurrmodel"s.js
				echo " " >> ./server/controllers/"$lowercurrmodel"s.js
				echo ""
				echo "this.destroy = function(req,res) {" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "     "$currmodel".remove({_id:req.params.id}, function(err,"$lowercurrmodel") {" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "       if(err) { res.json(err); }" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "       else { res.json("$lowercurrmodel"); }" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "     })" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "  }" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "}" >> ./server/controllers/"$lowercurrmodel"s.js
				echo ""
				echo "module.exports = new "$lowercurrmodel"sController"$parens"" >> ./server/controllers/"$lowercurrmodel"s.js
				objArr=false
			else
				echo "  this.index = function(req,res) {" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "     "$currmodel".find({}, function(err,"$lowercurrmodel"s) {" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "       if(err) { res.json(err); }" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "       else { res.json("$lowercurrmodel"s); }" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "     })" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "  }" >> ./server/controllers/"$lowercurrmodel"s.js
				echo " " >> ./server/controllers/"$lowercurrmodel"s.js
				echo ""	
				echo "  this.create = function(req,res) {" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "     var "$lowercurrmodel" = new" $currmodel"(req.body);" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "     "$lowercurrmodel".save(function(err) {" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "       if(err) { res.json(err); }" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "       else { res.redirect('/"$lowercurrmodel"s'); }" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "     })" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "  }" >> ./server/controllers/"$lowercurrmodel"s.js
				echo " " >> ./server/controllers/"$lowercurrmodel"s.js
				echo ""
				echo "  this.show = function(req,res) {" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "     "$currmodel".findOne({_id:req.params.id}, function(err,"$lowercurrmodel") {" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "       if(err) { res.json(err); }" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "       else { res.json("$lowercurrmodel"); }" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "     })" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "  }" >> ./server/controllers/"$lowercurrmodel"s.js
				echo " " >> ./server/controllers/"$lowercurrmodel"s.js
				echo ""
				echo "  this.update = function(req,res) {" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "     "$currmodel".update({_id:req.params.id}, req.body, function(err,"$lowercurrmodel") {" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "       if(err) { res.json(err); }" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "       else { res.json("$lowercurrmodel"); }" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "     })" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "  }" >> ./server/controllers/"$lowercurrmodel"s.js
				echo " " >> ./server/controllers/"$lowercurrmodel"s.js
				echo ""
				echo "  this.destroy = function(req,res) {" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "     "$currmodel".remove({_id:req.params.id}, function(err,"$lowercurrmodel") {" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "       if(err) { res.json(err); }" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "       else { res.json("$lowercurrmodel"); }" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "     })" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "  }" >> ./server/controllers/"$lowercurrmodel"s.js
				echo "}" >> ./server/controllers/"$lowercurrmodel"s.js
				echo ""
				echo "module.exports = new "$lowercurrmodel"sController"$parens"" >> ./server/controllers/"$lowercurrmodel"s.js
			fi
		fi
	done
}
controllers

#  /====================================================================/  #
#                                    routes                                #
#  /====================================================================/  #

for f in "${!models_array[@]}"; do
	currmodel="${models_array[$f+1]}"
	lowercurrmodel="$(echo $currmodel | tr '[:upper:]' '[:lower:]')"
	if [ "${models_array[$f]}" == 'model' ]; then
		echo "var "$lowercurrmodel"s = require('../controllers/"$lowercurrmodel"s.js');" >> ./server/config/routes.js
	fi
done
echo ""
echo "module.exports = function(app) {" >> ./server/config/routes.js
for f in "${!models_array[@]}"; do
	if [ "${models_array[$f]}" == 'model' ]; then
		currmodel="${models_array[$f+1]}"
		lowercurrmodel="$(echo $currmodel | tr '[:upper:]' '[:lower:]')"
		echo "  app.get('/"$lowercurrmodel"s', "$lowercurrmodel"s.index);" >> ./server/config/routes.js
		echo "  app.post('/"$lowercurrmodel"s', "$lowercurrmodel"s.create);" >> ./server/config/routes.js
		echo "  app.get('/"$lowercurrmodel"s/:id', "$lowercurrmodel"s.show);" >> ./server/config/routes.js
		echo "  app.put('/"$lowercurrmodel"s/:id', "$lowercurrmodel"s.update);" >> ./server/config/routes.js
		echo "  app.delete('/"$lowercurrmodel"s/:id', "$lowercurrmodel"s.destroy);" >> ./server/config/routes.js
	fi
done
echo "} " >> ./server/config/routes.js

#  /====================================================================/  #
#                               index.html (main)                          #
#  /====================================================================/  #

echo "<!DOCTYPE html>" >> ./client/index.html
echo "<html ng-app='app'>" >> ./client/index.html
echo "<head>" >> ./client/index.html
echo "  <title>"$project_name"</title>" >> ./client/index.html
echo "  <script src='angular/angular.js'></script>" >> ./client/index.html
echo "  <script src='angular-route/angular-route.js'></script>" >> ./client/index.html
echo "  <script src='app.js'></script>" >> ./client/index.html
for f in "${!models_array[@]}"; do
	if [ "${models_array[$f]}" == 'model' ]; then
		currmodel=${models_array[$f+1]}
		lowercurrmodel="$(echo $currmodel | tr '[:upper:]' '[:lower:]')"
		echo "  <script src=""'assets/js/"$currmodel"sFactory.js'""></script>" >> ./client/index.html
	fi
done
for f in "${!models_array[@]}"; do
	if [ "${models_array[$f]}" == 'model' ]; then
		currmodel=${models_array[$f+1]}
		lowercurrmodel="$(echo $currmodel | tr '[:upper:]' '[:lower:]')"
		echo "  <script src=""'assets/js/edit"$currmodel"Controller.js'""></script>" >> ./client/index.html
		echo "  <script src=""'assets/js/show"$currmodel"Controller.js'""></script>" >> ./client/index.html
		echo "  <script src=""'assets/js/new"$currmodel"Controller.js'""></script>" >> ./client/index.html
	fi
done
echo "  <script src='assets/js/indexController.js'></script>" >> ./client/index.html
echo "</head>" >> ./client/index.html
echo "<body>" >> ./client/index.html
echo "  <div ng-view></div>" >> ./client/index.html
echo "</body>" >> ./client/index.html
echo "</html>" >> ./client/index.html

#  /====================================================================/  #
#                                     app.js                               #
#  /====================================================================/  #

route='$routeProvider'
echo "var app = angular.module('app', ['ngRoute'])" >> ./client/app.js
echo "app.config(function("$route") {" >> ./client/app.js
echo "  "$route"" >> ./client/app.js
echo "    .when('/', {" >> ./client/app.js
echo "      templateUrl: 'assets/partials/index.html'," >> ./client/app.js
echo "      controller:  'indexController'" >> ./client/app.js
echo "    }) " >> ./client/app.js
for f in "${!models_array[@]}"; do
	currmodel=${models_array[$f+1]}
	lowercurrmodel="$(echo $currmodel | tr '[:upper:]' '[:lower:]')"
	if [ "${models_array[$f]}" == 'model' ]; then
		echo "    .when('/new/"$lowercurrmodel"', {" >> ./client/app.js
		echo "      templateUrl: 'assets/partials/new"$currmodel".html'," >> ./client/app.js
		echo "      controller:  'new"$currmodel"Controller'" >> ./client/app.js
		echo "    }) " >> ./client/app.js
	fi
done
for f in "${!models_array[@]}"; do
	currmodel=${models_array[$f+1]}
	lowercurrmodel="$(echo $currmodel | tr '[:upper:]' '[:lower:]')"
	if [ "${models_array[$f]}" == 'model' ]; then
		echo "    .when('/"$lowercurrmodel"/:id', {" >> ./client/app.js
		echo "      templateUrl: 'assets/partials/show"$currmodel".html'," >> ./client/app.js
		echo "      controller:  'show"$currmodel"Controller'" >> ./client/app.js
		echo "    }) " >> ./client/app.js
	fi
done
for f in "${!models_array[@]}"; do
	currmodel=${models_array[$f+1]}
	lowercurrmodel="$(echo $currmodel | tr '[:upper:]' '[:lower:]')"
	if [ "${models_array[$f]}" == 'model' ]; then
		echo "    .when('/"$lowercurrmodel"/edit/:id', {" >> ./client/app.js
		echo "      templateUrl: 'assets/partials/edit"$currmodel".html'," >> ./client/app.js
		echo "      controller:  'edit"$currmodel"Controller'" >> ./client/app.js
		echo "    }) " >> ./client/app.js
	fi
done
echo "     .otherwise('/');" >> ./client/app.js
echo " });" >> ./client/app.js

#  /====================================================================/  #
#                                   PARTIALS                               #
#  /====================================================================/  #

#  /====================================================================/  #
#                                  index.html                              #
#  /====================================================================/  #
function indexHtml() {
	for f in "${!models_array[@]}"; do
		if [ "${models_array[$f]}" == 'model' ]; then
			currmodel="${models_array[$f+1]}"
			# if [ "$currmodel" == 'User' ]; then
			# 	continue
			# else
			lowercurrmodel="$(echo $currmodel | tr '[:upper:]' '[:lower:]')"
			echo "<a href=""'#!/new/"$lowercurrmodel"'"">Create "$currmodel"</a>" >> ./client/assets/partials/index.html
			echo "" >> ./client/assets/partials/index.html
		fi
	done
	for f in "${!models_array[@]}"; do
		length=${#models_array[@]}
		declare -a attr_array
		if [ "${models_array[$f]}" == 'model' ]; then
			currmodel="${models_array[$f+1]}"
			lowercurrmodel="$(echo $currmodel | tr '[:upper:]' '[:lower:]')"
			echo "<h1>"${models_array[$f+1]}"</h1>" >> ./client/assets/partials/index.html
			echo "<table>" >> ./client/assets/partials/index.html
			echo " <tr>" >> ./client/assets/partials/index.html
		elif [ "${models_array[$f]}" == 'a_name' ]; then
			echo "   <th>"${models_array[$f+1]}"</th>" >> ./client/assets/partials/index.html
			attr_array+=(${models_array[$f+1]})
		elif [ "${models_array[$f+1]}" == 'model' ] || [ "$f" == "$(( length-1 ))" ]; then
			echo "   <th>Actions</th>" >> ./client/assets/partials/index.html
			echo "   </tr>" >> ./client/assets/partials/index.html
			echo "   <tr ng-repeat=""'"$lowercurrmodel" in "$lowercurrmodel"s'"">" >> ./client/assets/partials/index.html
			for g in "${!attr_array[@]}"; do
				echo "     <td ng-bind=""'"$lowercurrmodel"."${attr_array[$g]}"'""></td>" >> ./client/assets/partials/index.html
			done
			attr_array=()
			echo "     <td>" >> ./client/assets/partials/index.html
			echo "       <a href='#!/"$lowercurrmodel"/{{"$lowercurrmodel"._id}}'>Show</a>" >> ./client/assets/partials/index.html
			echo "       <a href='#!/"$lowercurrmodel"/edit/{{"$lowercurrmodel"._id}}'>Edit</a>" >> ./client/assets/partials/index.html
			echo "       <button ng-click='destroy"$currmodel"("$lowercurrmodel")'>X</button>" >> ./client/assets/partials/index.html
			echo "     </td>" >> ./client/assets/partials/index.html
			echo "   </tr>" >> ./client/assets/partials/index.html
			echo " </table>" >> ./client/assets/partials/index.html
		fi
	done
}
indexHtml
#  /====================================================================/  #
#                                    new.html                              #
#  /====================================================================/  #
function newHtml() {
	for f in "${!models_array[@]}"; do
		length=${#models_array[@]}
		if [ "${models_array[$f]}" == 'model' ]; then
			currmodel="${models_array[$f+1]}"
			lowercurrmodel="$(echo $currmodel | tr '[:upper:]' '[:lower:]')"
			echo "<h1>New "${models_array[$f+1]}"</h1>" >> ./client/assets/partials/new"$currmodel".html
			echo "<form ng-submit='create()'>" >> ./client/assets/partials/new"$currmodel".html
		elif [ "${models_array[$f]}" == 'a_name' ]; then
			if [ "${models_array[$f+3]}" == 'String' ]; then
				echo "  <input type='text' ng-model="$lowercurrmodel"."${models_array[$f+1]}">" >> ./client/assets/partials/new"$currmodel".html
	        elif [ "${models_array[$f+3]}" == 'Text' ]; then
	            echo "  <textarea cols='40' rows='4' ng-model="$lowercurrmodel"."${models_array[$f+1]}"></textarea>" >> ./client/assets/partials/new"$currmodel".html
			elif [ "${models_array[$f+3]}" == 'Number' ]; then
				echo "  <input type='number' ng-model="$lowercurrmodel"."${models_array[$f+1]}">" >> ./client/assets/partials/new"$currmodel".html
			elif [ "${models_array[$f+3]}" == 'Date' ]; then
				echo "  <input type='date' ng-model="$lowercurrmodel"."${models_array[$f+1]}">" >> ./client/assets/partials/new"$currmodel".html
			elif [ "${models_array[$f+3]}" == 'Boolean' ]; then
				echo "  <select ng-model="$lowercurrmodel"."${models_array[$f+1]}">" >> ./client/assets/partials/new"$currmodel".html
				echo "    <option>True</option>" >> ./client/assets/partials/new"$currmodel".html
				echo "    <option>False</option>" >> ./client/assets/partials/new"$currmodel".html
				echo "  </select>" >> ./client/assets/partials/new"$currmodel".html
			fi
		elif [ "${models_array[$f+1]}" == 'model' ] || [ "$f" == "$(( length-1 ))" ]; then
			echo "  <input type='submit' value='Create'>" >> ./client/assets/partials/new"$currmodel".html
			echo "</form>" >> ./client/assets/partials/new"$currmodel".html
		fi
	done
}
newHtml
#  /====================================================================/  #
#                                   edit.html                              #
#  /====================================================================/  #
function editHtml() {
	for n in "${!models_array[@]}"; do
	    length=${#models_array[@]}
	    if [ "${models_array[$n]}" == 'model' ]; then
	        currmodel="${models_array[$n+1]}"
	        lowercurrmodel="$(echo $currmodel | tr '[:upper:]' '[:lower:]')"
	        echo "<h1>Edit "${models_array[$n+1]}"</h1>" >> ./client/assets/partials/edit"$currmodel".html
	        echo "<form ng-submit='update()'>" >> ./client/assets/partials/edit"$currmodel".html
	    elif [ "${models_array[$n]}" == 'a_name' ]; then
	        if [ "${models_array[$n+3]}" == 'String' ]; then
	            echo "  <input type='text' ng-model="$lowercurrmodel"."${models_array[$n+1]}">" >> ./client/assets/partials/edit"$currmodel".html
	        elif [ "${models_array[$n+3]}" == 'Text' ]; then
	            echo "  <textarea cols='40' rows='4' ng-model="$lowercurrmodel"."${models_array[$n+1]}"></textarea>" >> ./client/assets/partials/edit"$currmodel".html
	        elif [ "${models_array[$n+3]}" == 'Number' ]; then
	            echo "  <input type='number' ng-model="$lowercurrmodel"."${models_array[$n+1]}">" >> ./client/assets/partials/edit"$currmodel".html
	        elif [ "${models_array[$n+3]}" == 'Date' ]; then
	            echo "  <input type='date' ng-model="$lowercurrmodel"."${models_array[$n+1]}">" >> ./client/assets/partials/edit"$currmodel".html
	        elif [ "${models_array[$n+3]}" == 'Boolean' ]; then
	            echo "  <select ng-model="$lowercurrmodel"."${models_array[$n+1]}">" >> ./client/assets/partials/edit"$currmodel".html
	            echo "    <option>True</option>" >> ./client/assets/partials/edit"$currmodel".html
	            echo "    <option>False</option>" >> ./client/assets/partials/edit"$currmodel".html
	            echo "  </select>" >> ./client/assets/partials/edit"$currmodel".html
	        fi
	    elif [ "${models_array[$n+1]}" == 'model' ] || [ "$n" == "$(( length-1 ))" ]; then
	        echo "  <input type='submit' value='Update'>" >> ./client/assets/partials/edit"$currmodel".html
	        echo "</form>" >> ./client/assets/partials/edit"$currmodel".html
	    fi
	done
}
editHtml

#  /====================================================================/  #
#                                   show.html                              #
#  /====================================================================/  #
function showHtml() {
	for f in "${!models_array[@]}"; do
	    if [ "${models_array[$f]}" == 'model' ]; then
	        currmodel="${models_array[$f+1]}"
	        lowercurrmodel="$(echo $currmodel | tr '[:upper:]' '[:lower:]')"
	        parens="()"
	        echo " <a href='#!/'>Home </a>" >> ./client/assets/partials/show"$currmodel".html
	    elif [ "${models_array[$f]}" == 'a_name' ]; then
	         echo "<p ng-bind='"$lowercurrmodel"."${models_array[$f+1]}"'></p>" >> ./client/assets/partials/show"$currmodel".html
	    fi
	done
}
showHtml

#  /====================================================================/  #
#                                   CONTROLLERS                            #
#  /====================================================================/  #

#  /====================================================================/  #
#                                 index controller                         #
#  /====================================================================/  #

declare -a factories_array
scope='$scope'
location='$location'
routeParams='$routeParams'
parens='()'
for f in "${!models_array[@]}"; do
	if [ "${models_array[$f]}" == 'model' ]; then
		factories_array+=(${models_array[$f+1]})
	fi
done
length=${#factories_array[@]}

echo "app.controller('indexController',[""'"$scope"'"", " >> ./client/assets/js/indexController.js
for g in "${!factories_array[@]}"; do
	echo "'"${factories_array[$g]}"sFactory', " >> ./client/assets/js/indexController.js
done
echo "function("$scope", " >> ./client/assets/js/indexController.js
for k in "${!factories_array[@]}"; do
	if [ "$k" == "$(( length-1 ))" ]; then
		echo ""${factories_array[$k]}"sFactory " >> ./client/assets/js/indexController.js
	else
		echo ""${factories_array[$k]}"sFactory, " >> ./client/assets/js/indexController.js
	fi
done
echo ") {" >> ./client/assets/js/indexController.js
for l in "${!factories_array[@]}"; do
	currfactory=${factories_array[$l]}
	lowercurrfactory="$(echo $currfactory | tr '[:upper:]' '[:lower:]')"
	echo " "$scope"."$lowercurrfactory"s = [];" >> ./client/assets/js/indexController.js
	echo " "$scope".get"$currfactory"s = function() { " >> ./client/assets/js/indexController.js
	echo "   "$currfactory"sFactory.index(function(data) {  " >> ./client/assets/js/indexController.js
	echo "      "$scope"."$lowercurrfactory"s = data;" >> ./client/assets/js/indexController.js
	echo "    })" >> ./client/assets/js/indexController.js
	echo " }" >> ./client/assets/js/indexController.js
	echo " "$scope".get"$currfactory"s"$parens"" >> ./client/assets/js/indexController.js
	echo "" >> ./client/assets/js/indexController.js
	echo " "$scope".destroy"$currfactory" = function("$lowercurrfactory") { " >> ./client/assets/js/indexController.js
	echo "   "$currfactory"sFactory.destroy("$lowercurrfactory", function(data) {  " >> ./client/assets/js/indexController.js
	echo "      "$scope"."$lowercurrfactory"s = data;" >> ./client/assets/js/indexController.js
	echo "    })" >> ./client/assets/js/indexController.js
	echo " }" >> ./client/assets/js/indexController.js
done
echo "}])" >> ./client/assets/js/indexController.js

#  /====================================================================/  #
#                                newController.js                          #
#  /====================================================================/  #

for f in "${!models_array[@]}"; do
	if [ "${models_array[$f]}" == 'model' ]; then
		currmodel="${models_array[$f+1]}"
		lowercurrmodel="$(echo $currmodel | tr '[:upper:]' '[:lower:]')"
		touch ./client/assets/js/new"$currmodel"Controller.js
		echo "app.controller('new"$currmodel"Controller',['"$scope"', '"$location"', '"$currmodel"sFactory', " >> ./client/assets/js/new"$currmodel"Controller.js
		echo " function("$scope", "$location", "$currmodel"sFactory) {" >> ./client/assets/js/new"$currmodel"Controller.js
		echo " "$scope".create = function() { " >> ./client/assets/js/new"$lowercurrmodel"Controller.js
		echo "   "$currmodel"sFactory.create("$scope"."$lowercurrmodel", function(data) {  " >> ./client/assets/js/new"$lowercurrmodel"Controller.js
		echo "      "$scope"."$lowercurrmodel" = data;" >> ./client/assets/js/new"$lowercurrmodel"Controller.js
		echo "       "$location".url('/');" >> ./client/assets/js/new"$lowercurrmodel"Controller.js
		echo "    })" >> ./client/assets/js/new"$lowercurrmodel"Controller.js
		echo " }" >> ./client/assets/js/new"$lowercurrmodel"Controller.js
		echo "" >> ./client/assets/js/new"$lowercurrmodel"Controller.js
		echo "}])" >> ./client/assets/js/new"$lowercurrmodel"Controller.js
	fi
done

#  /====================================================================/  #
#                               editController.js                          #
#  /====================================================================/  #
for f in "${!models_array[@]}"; do
  if [ "${models_array[$f]}" == 'model' ]; then
    parens='()'
    currmodel="${models_array[$f+1]}"
    lowercurrmodel="$(echo $currmodel | tr '[:upper:]' '[:lower:]')"
    echo "app.controller('edit"$currmodel"Controller',['"$scope"','"$routeParams"','"$location"','"$currmodel"sFactory', " >> ./client/assets/js/edit"$currmodel"Controller.js
    echo "function("$scope","$routeParams","$location","$currmodel"sFactory) {"  >> ./client/assets/js/edit"$currmodel"Controller.js
    echo " "$scope".get"$currmodel" = function"$parens" {" >> ./client/assets/js/edit"$currmodel"Controller.js
    echo "  "$currmodel"sFactory.show("$routeParams".id, function(data) {" >> ./client/assets/js/edit"$currmodel"Controller.js
    echo "    "$scope"."$lowercurrmodel" = data;" >> ./client/assets/js/edit"$currmodel"Controller.js
    echo "  });" >> ./client/assets/js/edit"$currmodel"Controller.js
    echo " };" >> ./client/assets/js/edit"$currmodel"Controller.js
    echo " "$scope."get"$currmodel""$parens";" >> ./client/assets/js/edit"$currmodel"Controller.js
    echo " "$scope".update = function() { " >> ./client/assets/js/edit"$currmodel"Controller.js
    echo "   "$currmodel"sFactory.update("$scope"."$lowercurrmodel", "$routeParams".id)" >> ./client/assets/js/edit"$currmodel"Controller.js
    echo "   "$location".url('/')" >> ./client/assets/js/edit"$currmodel"Controller.js
    echo " }" >> ./client/assets/js/edit"$currmodel"Controller.js
    echo "}])" >> ./client/assets/js/edit"$currmodel"Controller.js
  fi
done

#  /====================================================================/  #
#                               showController.js                          #
#  /====================================================================/  #
for f in "${!models_array[@]}"; do
  if [ "${models_array[$f]}" == 'model' ]; then
    currmodel="${models_array[$f+1]}"
    lowercurrmodel="$(echo $currmodel | tr '[:upper:]' '[:lower:]')"
    touch ./client/assets/js/show"$currmodel"Controller.js

	echo "app.controller('show"$currmodel"Controller',['"$scope"','"$routeParams"', '"$currmodel"sFactory', " >> ./client/assets/js/show"$currmodel"Controller.js
    echo "function("$scope","$routeParams","$currmodel"sFactory ) {"  >> ./client/assets/js/show"$currmodel"Controller.js
	echo " "$currmodel"sFactory.show("$routeParams".id, function(data){" >> ./client/assets/js/show"$currmodel"Controller.js
	echo " 		"$scope"."$lowercurrmodel" = data" >> ./client/assets/js/show"$currmodel"Controller.js
    echo " 	})" >> ./client/assets/js/show"$currmodel"Controller.js
    echo "}])" >> ./client/assets/js/show"$currmodel"Controller.js
  fi
done

#  /====================================================================/  #
#                                    FACTORIES                             #
#  /====================================================================/  #

http='$http'
parens="()"
for f in "${!models_array[@]}"; do
	if [ "${models_array[$f]}" == 'model' ]; then
		currfactory=${models_array[$f+1]}"s"
	    lowercurrfactory="$(echo $currfactory | tr '[:upper:]' '[:lower:]')"
		echo "app.factory(""'"$currfactory"Factory', ['"$http"', function("$http"){" >> ./client/assets/js/"$currfactory"Factory.js
		echo "  function "$currfactory"Factory"$parens"{" >> ./client/assets/js/"$currfactory"Factory.js
		echo "    this.index = function(callback) {" >> ./client/assets/js/"$currfactory"Factory.js
		echo "      "$http".get('/"$lowercurrfactory"').then(function(res) {" >> ./client/assets/js/"$currfactory"Factory.js
		echo "        if(callback && typeof callback == 'function') {" >> ./client/assets/js/"$currfactory"Factory.js
		echo "          callback(res.data);" >> ./client/assets/js/"$currfactory"Factory.js
		echo "        }" >> ./client/assets/js/"$currfactory"Factory.js
		echo "      })" >> ./client/assets/js/"$currfactory"Factory.js
		echo "    }" >> ./client/assets/js/"$currfactory"Factory.js
		echo "    this.create = function(data, callback) {" >> ./client/assets/js/"$currfactory"Factory.js
		echo "      "$http".post('/"$lowercurrfactory"', data).then(function(res) {" >> ./client/assets/js/"$currfactory"Factory.js
		echo "        if(callback && typeof callback == 'function') {" >> ./client/assets/js/"$currfactory"Factory.js
		echo "          callback(res.data);" >> ./client/assets/js/"$currfactory"Factory.js
		echo "        }" >> ./client/assets/js/"$currfactory"Factory.js
		echo "      })" >> ./client/assets/js/"$currfactory"Factory.js
		echo "    }" >> ./client/assets/js/"$currfactory"Factory.js
		echo "    this.show = function(data, callback) {" >> ./client/assets/js/"$currfactory"Factory.js
		echo "      "$http".get('/"$lowercurrfactory"/'+ data).then(function(res) {" >> ./client/assets/js/"$currfactory"Factory.js
		echo "        if(callback && typeof callback == 'function') {" >> ./client/assets/js/"$currfactory"Factory.js
		echo "          callback(res.data);" >> ./client/assets/js/"$currfactory"Factory.js
		echo "        }" >> ./client/assets/js/"$currfactory"Factory.js
		echo "      })" >> ./client/assets/js/"$currfactory"Factory.js
		echo "    }" >> ./client/assets/js/"$currfactory"Factory.js
		echo "    this.update = function(data, id) {" >> ./client/assets/js/"$currfactory"Factory.js
		echo "      "$http".put('/"$lowercurrfactory"/' + id, data).then(function(res){});" >> ./client/assets/js/"$currfactory"Factory.js
		echo "    }" >> ./client/assets/js/"$currfactory"Factory.js
		echo "    this.destroy = function(data, callback) {" >> ./client/assets/js/"$currfactory"Factory.js
		echo "      var id = data._id;" >> ./client/assets/js/"$currfactory"Factory.js
		echo "      "$http".delete('/"$lowercurrfactory"/' + id).then(function(res) {" >> ./client/assets/js/"$currfactory"Factory.js
		echo "        "$http".get('/"$lowercurrfactory"').then(function(newRes) {" >> ./client/assets/js/"$currfactory"Factory.js
		echo "          if(callback && typeof callback == 'function') {" >> ./client/assets/js/"$currfactory"Factory.js
		echo "            callback(newRes.data);" >> ./client/assets/js/"$currfactory"Factory.js
		echo "          }" >> ./client/assets/js/"$currfactory"Factory.js
		echo "        })" >> ./client/assets/js/"$currfactory"Factory.js
		echo "      })" >> ./client/assets/js/"$currfactory"Factory.js
		echo "    }" >> ./client/assets/js/"$currfactory"Factory.js
		echo "  }" >> ./client/assets/js/"$currfactory"Factory.js
		echo "  return new "$currfactory"Factory"$parens";" >> ./client/assets/js/"$currfactory"Factory.js
		echo "}])" >> ./client/assets/js/"$currfactory"Factory.js
	fi
done