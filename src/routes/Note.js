const express = require('express');
const router = express.Router();

const Note = require('./../models/Note');

router.post("/list", async function(req, res) {
    try {
        console.log("Received request to list notes for userid:", req.body.userid);
        var notes = await Note.find({ userid: req.body.userid });
        console.log("Found notes:", notes);
        res.json(notes);
    } catch (error) {
        console.error("Error listing notes:", error);
        res.status(500).json({ message: "Internal Server Error" });
    }
});


router.post("/add", async function(req, res) {       
    
    await Note.deleteOne({ id: req.body.id });

    const newNote = new Note({
        id: req.body.id,
        userid: req.body.userid,
        title: req.body.title,
        content: req.body.content
    });
    await newNote.save();

    const response = { message: "New Note Created! " + `id: ${req.body.id}` };
    res.json(response);

});

router.post("/delete", async function(req, res) {
    await Note.deleteOne({ id: req.body.id });
    const response = { message: "Note Deleted! " + `id: ${req.body.id}` };
    res.json(response);
});

module.exports = router;