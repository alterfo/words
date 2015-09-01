'use strict';
var
    request = require('supertest'),
    should = require('should');


var app = require('../../server'),
    mongoose = require('mongoose'),
    User = mongoose.model('User'),
    Text = mongoose.model('Text');


// Зайти, сохранить, получить то что сохранил
// Выйти, сохранить, получить ошибку





/**
 * Globals
 */
var credentials, user, text, agent, userId;

/**
 * Text routes tests
 */
describe('Text CRUD tests', function() {
    before(function(done) {
        // Create user credentials
        credentials = {
            username: 'username',
            password: 'password'
        };

        // Create a new user
        user = new User({
            firstName: 'Full',
            lastName: 'Name',
            displayName: 'Full Name',
            email: 'test@test.com',
            username: credentials.username,
            password: credentials.password,
            provider: 'local'
        });

        // Save a user to the test db and create new text
        user.save(function() {
            text = {
                text: "Bla bla bla",
                counter: 3
            };

            done();
        });

        agent = request.agent(app);

    });

    it('should be able to log in', function(done) {
        agent.post('/auth/signin')
            .send(credentials)
            .expect(200)
            .end(function(err, res) {

                if (err) done(err);
                // Get the userId
                userId = user._id.toString();
                // Save a new text
                done();
            });
    });

    it('should be able to save text', function(done) {
        agent.post('/texts')
            .send(text)
            .expect(200)
            .end(function(err, res) {
                // Handle text save error
                if (err) done(err);

                done();
            });
    });

    it('should get saved text properly', function(done) {
        agent.get('/today')
            .expect(200).end(function(err, res) {

                // Handle text save error
                if (err) done(err);
                var text = JSON.parse(res.text);
                // Set assertions

                text.should.be.an.instanceOf(Object)
                    .and.have.properties({
                        'user': userId,
                        'text': 'Bla bla bla'
                    });

                done();
            });
    });


    it('should be able to log out', function(done) {
        agent.post('/auth/signout')
            .expect(200)
            .end(function(err, res) {
                done();
            });
    });




    it('should not be able to save an text if not logged in', function(done) {

        request(app).post('/texts')
            .send(text)
            .expect(401)
            .end(function(textSaveErr, textSaveRes) {
                // Call the assertion callback
                done(textSaveErr);
            });
    });

    // it('should not be able to save an text if no title is provided', function(done) {
    //     // Invalidate title field
    //     text.title = '';

    //     agent.post('/auth/signin')
    //         .send(credentials)
    //         .expect(200)
    //         .end(function(signinErr, signinRes) {
    //             // Handle signin error
    //             if (signinErr) done(signinErr);

    //             // Get the userId
    //             var userId = user.id;

    //             // Save a new text
    //             agent.post('/texts')
    //                 .send(text)
    //                 .expect(400)
    //                 .end(function(textSaveErr, textSaveRes) {
    //                     // Set message assertion
    //                     (textSaveRes.body.message).should.match('Title cannot be blank');

    //                     // Handle text save error
    //                     done(textSaveErr);
    //                 });
    //         });
    // });

    // it('should be able to update an text if signed in', function(done) {
    //     agent.post('/auth/signin')
    //         .send(credentials)
    //         .expect(200)
    //         .end(function(signinErr, signinRes) {
    //             // Handle signin error
    //             if (signinErr) done(signinErr);

    //             // Get the userId
    //             var userId = user.id;

    //             // Save a new text
    //             agent.post('/texts')
    //                 .send(text)
    //                 .expect(200)
    //                 .end(function(textSaveErr, textSaveRes) {
    //                     // Handle text save error
    //                     if (textSaveErr) done(textSaveErr);

    //                     // Update text title
    //                     text.title = 'WHY YOU GOTTA BE SO MEAN?';

    //                     // Update an existing text
    //                     agent.put('/texts/' + textSaveRes.body._id)
    //                         .send(text)
    //                         .expect(200)
    //                         .end(function(textUpdateErr, textUpdateRes) {
    //                             // Handle text update error
    //                             if (textUpdateErr) done(textUpdateErr);

    //                             // Set assertions
    //                             (textUpdateRes.body._id).should.equal(textSaveRes.body._id);
    //                             (textUpdateRes.body.title).should.match('WHY YOU GOTTA BE SO MEAN?');

    //                             // Call the assertion callback
    //                             done();
    //                         });
    //                 });
    //         });
    // });

    // it('should be able to get a list of texts if not signed in', function(done) {
    //     // Create new text model instance
    //     var textObj = new Text(text);

    //     // Save the text
    //     textObj.save(function() {
    //         // Request texts
    //         request(app).get('/texts')
    //             .end(function(req, res) {
    //                 // Set assertion
    //                 res.body.should.be.an.Array.with.lengthOf(1);

    //                 // Call the assertion callback
    //                 done();
    //             });

    //     });
    // });


    // it('should be able to get a single text if not signed in', function(done) {
    //     // Create new text model instance
    //     var textObj = new Text(text);

    //     // Save the text
    //     textObj.save(function() {
    //         request(app).get('/texts/' + textObj._id)
    //             .end(function(req, res) {
    //                 // Set assertion
    //                 res.body.should.be.an.Object.with.property('title', text.title);

    //                 // Call the assertion callback
    //                 done();
    //             });
    //     });
    // });

    // it('should be able to delete an text if signed in', function(done) {
    //     agent.post('/auth/signin')
    //         .send(credentials)
    //         .expect(200)
    //         .end(function(signinErr, signinRes) {
    //             // Handle signin error
    //             if (signinErr) done(signinErr);

    //             // Get the userId
    //             var userId = user.id;

    //             // Save a new text
    //             agent.post('/texts')
    //                 .send(text)
    //                 .expect(200)
    //                 .end(function(textSaveErr, textSaveRes) {
    //                     // Handle text save error
    //                     if (textSaveErr) done(textSaveErr);

    //                     // Delete an existing text
    //                     agent.delete('/texts/' + textSaveRes.body._id)
    //                         .send(text)
    //                         .expect(200)
    //                         .end(function(textDeleteErr, textDeleteRes) {
    //                             // Handle text error error
    //                             if (textDeleteErr) done(textDeleteErr);

    //                             // Set assertions
    //                             (textDeleteRes.body._id).should.equal(textSaveRes.body._id);

    //                             // Call the assertion callback
    //                             done();
    //                         });
    //                 });
    //         });
    // });

    // it('should not be able to delete an text if not signed in', function(done) {
    //     // Set text user 
    //     text.user = user;

    //     // Create new text model instance
    //     var textObj = new Text(text);

    //     // Save the text
    //     textObj.save(function() {
    //         // Try deleting text
    //         request(app).delete('/texts/' + textObj._id)
    //             .expect(401)
    //             .end(function(textDeleteErr, textDeleteRes) {
    //                 // Set message assertion
    //                 (textDeleteRes.body.message).should.match('User is not logged in');

    //                 // Handle text error error
    //                 done(textDeleteErr);
    //             });

    //     });
    // });

    after(function(done) {
        User.remove().exec();
        Text.remove().exec();
        done();
    });
});
